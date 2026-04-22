"""
Fix missing @after attributes on last morphemes of orthographic words in nodes XML.

For each orthographic word (group of <m> elements sharing a @word attribute),
the last morpheme should carry the inter-word separator in @after:
  - '־'  if the word text ends with maqaf (already embedded in text)
  - ' '  for normal word separation
  - ''   for end-of-verse (sof pasuq etc. is in the word text)

The TEI files are the authoritative source: the combined text of each <w>'s
<m> children tells us the separator type.

Only fixes <m> elements where @after is empty ('') or absent, and the word
is not the last in its verse. Does not touch @after values that are already set.

Uses lxml for parsing (safe XML handling) and targeted string replacement for
writing (preserves original whitespace and attribute formatting).

Usage:
    python python/fix_missing_after.py [--dry-run]
"""

import argparse
import collections
import re
from pathlib import Path
from lxml import etree

REPO_ROOT = Path(__file__).parent.parent
NODES_DIR = REPO_ROOT / "WLC" / "nodes"
TEI_DIR = REPO_ROOT / "WLC" / "tei"

XML_ID = "{http://www.w3.org/XML/1998/namespace}id"


def build_after_map_from_tei(tei_path):
    """
    Parse a TEI file and return a dict mapping word ref (e.g. 'EXO 20:2!1')
    to the correct @after value.

    Rules derived from TEI <w> text:
      - ends with maqaf ־  → after = '־'
      - last word in verse  → after = ''  (sof pasuq is in the text)
      - otherwise           → after = ' '
    """
    after_map = {}
    tree = etree.parse(str(tei_path))
    root = tree.getroot()

    for verse in root.iter("verse"):
        words = verse.findall("w")
        for i, w in enumerate(words):
            ref = w.get("ref", "")
            if not ref:
                continue
            text = "".join((m.text or "") for m in w.findall("m"))
            is_last = (i == len(words) - 1)
            if is_last:
                after = ""
            elif text.endswith("־"):
                after = "־"
            else:
                after = " "
            after_map[ref] = after

    return after_map


def collect_fixes(nodes_path, after_map):
    """
    Use lxml to parse the nodes file and return a dict of
    {xml_id: (existing_after, correct_after)} for elements that need fixing.

    existing_after is "" (empty string) or None (absent).
    """
    fixes = {}
    tree = etree.parse(str(nodes_path))
    root = tree.getroot()

    for sentence in root.iter("Sentence"):
        word_groups = collections.OrderedDict()
        for m in sentence.iter("m"):
            w = m.get("word", "")
            if w not in word_groups:
                word_groups[w] = []
            word_groups[w].append(m)

        word_ids = list(word_groups.keys())
        for i, word_id in enumerate(word_ids):
            morphs = word_groups[word_id]
            last_m = morphs[-1]
            existing_after = last_m.get("after", None)
            is_last_in_verse = (i == len(word_ids) - 1)

            if (existing_after == "" or existing_after is None) and not is_last_in_verse:
                correct_after = after_map.get(word_id)
                if correct_after is not None and correct_after != existing_after:
                    xml_id = last_m.get(XML_ID)
                    if xml_id:
                        fixes[xml_id] = (existing_after, correct_after)

    return fixes


def apply_fix_to_text(text, xml_id, existing_after, new_after):
    """
    Find the <m element with given xml:id in raw text and update/add @after.

    Uses string operations only — never re-serializes the XML tree,
    so original whitespace and attribute formatting are preserved.

    Returns (new_text, changed: bool).
    """
    id_attr = f'xml:id="{xml_id}"'
    id_pos = text.find(id_attr)
    if id_pos == -1:
        return text, False

    # Find the start of this <m element (search backward)
    elem_start = text.rfind('<m ', 0, id_pos)
    if elem_start == -1:
        return text, False

    # Find the end of the opening tag (first > after elem_start)
    gt_pos = text.find('>', elem_start)
    if gt_pos == -1:
        return text, False

    elem_tag = text[elem_start:gt_pos + 1]

    if existing_after == "":
        # Replace after="" with after="<new_after>"
        if 'after=""' not in elem_tag:
            return text, False
        new_elem_tag = elem_tag.replace('after=""', f'after="{new_after}"', 1)
        new_text = text[:elem_start] + new_elem_tag + text[gt_pos + 1:]
        return new_text, True

    else:
        # after attribute is absent — insert it after lang="H" to match convention
        m = re.search(r'(\n([ \t]+)lang="H")', elem_tag)
        if m:
            indent = m.group(2)
            insert = f'\n{indent}after="{new_after}"'
            insert_pos = m.end()
            new_elem_tag = elem_tag[:insert_pos] + insert + elem_tag[insert_pos:]
            new_text = text[:elem_start] + new_elem_tag + text[gt_pos + 1:]
            return new_text, True
        return text, False


def fix_nodes_file(nodes_path, after_map, dry_run=False):
    """
    Fix @after on last morphemes of words where it is empty or missing.

    Parses with lxml to find what needs fixing, then applies targeted
    string replacements to preserve the original whitespace formatting.

    Returns count of fixes applied.
    """
    fixes = collect_fixes(nodes_path, after_map)
    if not fixes:
        return 0

    text = nodes_path.read_text(encoding="utf-8")
    fixed = 0

    for xml_id, (existing_after, new_after) in fixes.items():
        text, changed = apply_fix_to_text(text, xml_id, existing_after, new_after)
        if changed:
            fixed += 1

    if fixed > 0 and not dry_run:
        nodes_path.write_text(text, encoding="utf-8")

    return fixed


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--dry-run", action="store_true",
                        help="Report fixes without writing files")
    args = parser.parse_args()

    tei_files = sorted(TEI_DIR.glob("*.xml"))
    total_fixed = 0
    files_fixed = 0

    for tei_path in tei_files:
        after_map = build_after_map_from_tei(tei_path)
        if not after_map:
            continue

        book_prefix = tei_path.stem.split("-")[0]  # e.g. "01" from "01-genesis"
        nodes_files = sorted(NODES_DIR.glob(f"{book_prefix}-*.xml"))

        for nodes_path in nodes_files:
            if nodes_path.name == "macula-hebrew.xml":
                continue
            fixed = fix_nodes_file(nodes_path, after_map, dry_run=args.dry_run)
            if fixed:
                files_fixed += 1
                total_fixed += fixed
                action = "would fix" if args.dry_run else "fixed"
                print(f"  {nodes_path.name}: {action} {fixed}")

    action = "Would fix" if args.dry_run else "Fixed"
    print(f"\n{action} {total_fixed} @after attributes across {files_fixed} files.")


if __name__ == "__main__":
    main()
