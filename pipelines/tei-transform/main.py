import sys
import concurrent.futures
import multiprocessing
import os
from pathlib import Path

from requests import Session
from lxml import etree
from biblelib import book

try:
    REPO_ROOT = Path(__file__).parent.parent.parent
except NameError:
    REPO_ROOT = Path(os.getcwd()).parent.parent

PIPELINE_ROOT = REPO_ROOT / "pipelines" / "tei-transform"
MAX_WORKERS = int(os.environ.get("MAX_WORKERS", multiprocessing.cpu_count() - 1))
TANACH_BOOK_URL_ROOT = "https://tanach.us/Books/"

BOOK_DATA = book.Books()

XML_PATH = REPO_ROOT / "sources/tanach.us/xml"
TEI_PATH = REPO_ROOT / "WLC/tei"


def get_source_paths():
    for path in XML_PATH.glob("*.xml"):
        yield path


def do_transform(source):
    print(f"transforming {source.name}")
    parsed = etree.parse(source)
    book_name = parsed.xpath("//book/names/name")[0].text
    book_data = next(iter(filter(lambda x: x.name == book_name, BOOK_DATA.values())), None)
    assert book_data
    # usfm_ref = book_data.usfmname
    dest_name = f'{book_data.usfmnumber}-{book_data.name.lower().replace(" ", "")}.xml'
    dest = TEI_PATH / dest_name
    with dest.open("w") as f:
        f.write(etree.tostring(parsed, pretty_print=True, encoding="unicode"))
    # FIXME: Actually transform this XML
    # transformer = XSLTransformer(usfm_ref, etree.parse(source.open("rb")))
    # with dest.open("w") as f:
    #     f.write(transformer.render())


def serial_transform():
    for source_path in get_source_paths():
        do_transform(source_path)


def parallel_transform():
    exceptions = []
    with concurrent.futures.ProcessPoolExecutor(max_workers=MAX_WORKERS) as executor:
        deferred_tasks = {}
        for source_path in get_source_paths():
            deferred = executor.submit(do_transform, source_path)
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
