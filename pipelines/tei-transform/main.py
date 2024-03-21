import csv
import sys
import concurrent.futures
import multiprocessing
import os
from pathlib import Path

from requests import Session
from lxml import etree
from biblelib import book
from biblelib.word import fromusfm


try:
    REPO_ROOT = Path(__file__).parent.parent.parent
except NameError:
    REPO_ROOT = Path(os.getcwd()).parent.parent

MACULA_NODES_TSV = REPO_ROOT / "WLC/tsv/macula-hebrew.tsv"

XML_NS = "{http://www.w3.org/XML/1998/namespace}"

PIPELINE_ROOT = REPO_ROOT / "pipelines" / "tei-transform"
MAX_WORKERS = int(os.environ.get("MAX_WORKERS", multiprocessing.cpu_count() - 1))
TANACH_BOOK_URL_ROOT = "https://tanach.us/Books/"
MACULA_ID_PREFIX = "o"
ELIGIBLE_V_ELEMS = {"w", "q"}

BOOK_DATA = book.Books()

XML_PATH = REPO_ROOT / "sources/tanach.us/xml"
TEI_PATH = REPO_ROOT / "WLC/tei"


def get_source_paths():
    for path in XML_PATH.glob("*.xml"):
        if path.name == "Ruth.xml":
            yield path


def get_macula_word_id(bcv, pos):
    return f"{MACULA_ID_PREFIX}{bcv}{str(pos).zfill(3)}"


def build_tokens_by_bcv_lookup():
    bcv_lookup = {}
    for row in csv.DictReader(MACULA_NODES_TSV.open(), delimiter="\t"):
        macula_id = row["xml:id"]
        bcv = macula_id[0:9]
        bcv_lookup.setdefault(bcv, []).append(row)
    return bcv_lookup


def regroup_tokens_by_bcvw(tokens):
    bcvw_lookup = {}
    for token in tokens:
        key = (token["ref"], token["xml:id"][0:12])
        bcvw_lookup.setdefault(key, []).append(token)
    return bcvw_lookup


def do_transform(source, tokens_lookup):
    print(f"transforming {source.name}")
    parsed = etree.parse(source)
    book_name = parsed.xpath("//book/names/name")[0].text
    heb_book_name = parsed.xpath("//book/names/hebrewname")[0].text
    book_data = next(iter(filter(lambda x: x.name == book_name, BOOK_DATA.values())), None)
    assert book_data
    usfm_ref = book_data.usfmname
    dest_name = f'{book_data.usfmnumber}-{book_data.name.lower().replace(" ", "")}.xml'
    dest = TEI_PATH / dest_name
    book_xml = etree.Element("div", attrib={"type": "book", "ref": usfm_ref, "canonical": "true"})
    tree = etree.ElementTree(book_xml)
    # NOTE: This is largely intended for local debugging
    stylesheet_pi = etree.ProcessingInstruction(
        "xml-stylesheet", 'type="text/css" href="wlc-tei.css"'
    )
    book_xml.addprevious(stylesheet_pi)
    title = etree.Element("title", attrib={"type": "main"})
    title.text = heb_book_name
    book_xml.append(title)
    for c_elem in parsed.xpath("//c"):
        chapter_ref = f'{usfm_ref} {c_elem.attrib["n"]}'
        chapter = etree.Element("chapter", attrib={"ref": chapter_ref})
        for v_elem in c_elem.xpath("./v"):
            verse_ref = f'{chapter_ref}:{v_elem.attrib["n"]}'
            verse = etree.Element("verse", attrib={"ref": verse_ref})
            verse.append(
                etree.Element(
                    "milestone", attrib={"unit": "verse", "ref": verse_ref, "n": v_elem.attrib["n"]}
                )
            )
            bcv = fromusfm(verse_ref).ID
            key = f"{MACULA_ID_PREFIX}{bcv}"
            tokens = tokens_lookup[key]
            for token in tokens:
                word = etree.Element(
                    "w", attrib={f"{XML_NS}id": token["xml:id"], "ref": token["ref"]}
                )
                if not token["text"]:
                    # e.g. o080010010071ה
                    continue
                word.text = token["text"]
                if token["after"]:
                    word.text += token["after"]
                add_whitespace = word.text[-1] == " "
                word.text = word.text.strip()
                if add_whitespace:
                    word.tail = " "
                verse.append(word)
            chapter.append(verse)
        book_xml.append(chapter)

    with dest.open("wb") as f:
        f.write(
            etree.tostring(
                tree,
                pretty_print=True,
                xml_declaration=True,
                encoding="UTF-8",
            )
        )
    # FIXME: Actually transform this XML
    # transformer = XSLTransformer(usfm_ref, etree.parse(source.open("rb")))
    # with dest.open("w") as f:
    #     f.write(transformer.render())


def serial_transform():
    tokens_by_bcv_lookup = build_tokens_by_bcv_lookup()
    for source_path in get_source_paths():
        do_transform(source_path, tokens_by_bcv_lookup)


def parallel_transform():
    exceptions = []
    tokens_by_bcv_lookup = build_tokens_by_bcv_lookup()
    with concurrent.futures.ProcessPoolExecutor(max_workers=MAX_WORKERS) as executor:
        deferred_tasks = {}
        for source_path in get_source_paths():
            deferred = executor.submit(do_transform, source_path, tokens_by_bcv_lookup)
            deferred_tasks[deferred] = source_path

        for f in concurrent.futures.as_completed(deferred_tasks):
            try:
                f.result()
            except Exception as exc:
                exceptions.append(exc)

    if exceptions:
        raise exceptions[0]


def fetch_xml():
    s = Session()
    for source_path in get_source_paths():
        book_url = f"{TANACH_BOOK_URL_ROOT}{source_path.name}"
        resp = s.get(book_url)
        with source_path.open("w") as f:
            f.write(resp.content.decode("utf-8"))


def main():
    TEI_PATH.mkdir(parents=True, exist_ok=True)
    fetch = len(sys.argv) > 1 and sys.argv[1] == "--fetch"
    if fetch:
        print("Fetching XML from Tanach.us")
        fetch_xml()

    parallel_transform()


if __name__ == "__main__":
    main()
