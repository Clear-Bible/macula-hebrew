"""
Fix double-possessive glosses on construct-state noun tokens.

Construct-state nouns followed by a pronominal suffix carry compound
contextual glosses like 'his.wife', 'her.mother', 'my.lord'. The
suffix token already carries the possessive ('his', 'her', 'my'), so
assembling a word gloss produces 'his wife his', 'her mother her', etc.

Fix: strip the possessive prefix from the construct-noun gloss, leaving
the lexical part only ('wife', 'mother', 'lord'). The suffix token
remains unchanged.

Affected: <m> elements where @morph ends in 'c' (construct state) and
@gloss starts with one of: his. her. my. our. your. their. its.

Uses lxml for parsing (safe XML handling) and targeted string
replacement for writing (preserves original whitespace formatting).

Usage:
    python python/fix_double_possessive.py [--dry-run]
"""

import argparse
import re
from pathlib import Path
from lxml import etree

REPO_ROOT = Path(__file__).parent.parent
NODES_DIR = REPO_ROOT / "WLC" / "nodes"

XML_ID = "{http://www.w3.org/XML/1998/namespace}id"

POSSESSIVE_PREFIX = re.compile(r"^(his|her|my|our|your|their|its)\.")


def collect_fixes(nodes_path):
    """
    Parse the nodes file and return a dict of
    {xml_id: (old_gloss, new_gloss)} for construct-state nouns
    with possessive-prefixed glosses.
    """
    fixes = {}
    tree = etree.parse(str(nodes_path))

    for m in tree.getroot().iter("m"):
        morph = m.get("morph", "")
        gloss = m.get("gloss", "")
        if morph.endswith("c") and POSSESSIVE_PREFIX.match(gloss):
            new_gloss = POSSESSIVE_PREFIX.sub("", gloss)
            xml_id = m.get(XML_ID)
            if xml_id:
                fixes[xml_id] = (gloss, new_gloss)

    return fixes


def apply_fix_to_text(text, xml_id, old_gloss, new_gloss):
    """
    Find the <m element with given xml:id and replace its gloss value.
    Uses string operations only — preserves original whitespace.
    Returns (new_text, changed: bool).
    """
    id_attr = f'xml:id="{xml_id}"'
    id_pos = text.find(id_attr)
    if id_pos == -1:
        return text, False

    elem_start = text.rfind("<m ", 0, id_pos)
    if elem_start == -1:
        return text, False

    gt_pos = text.find(">", elem_start)
    if gt_pos == -1:
        return text, False

    elem_tag = text[elem_start : gt_pos + 1]

    old_attr = f'gloss="{old_gloss}"'
    new_attr = f'gloss="{new_gloss}"'

    if old_attr not in elem_tag:
        return text, False

    new_elem_tag = elem_tag.replace(old_attr, new_attr, 1)
    return text[:elem_start] + new_elem_tag + text[gt_pos + 1 :], True


def fix_nodes_file(nodes_path, dry_run=False):
    """
    Fix double-possessive glosses in a single nodes file.
    Returns count of fixes applied.
    """
    fixes = collect_fixes(nodes_path)
    if not fixes:
        return 0

    text = nodes_path.read_text(encoding="utf-8")
    fixed = 0

    for xml_id, (old_gloss, new_gloss) in fixes.items():
        text, changed = apply_fix_to_text(text, xml_id, old_gloss, new_gloss)
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

    total_fixed = 0
    files_fixed = 0

    for nodes_path in sorted(NODES_DIR.glob("*.xml")):
        if nodes_path.name == "macula-hebrew.xml":
            continue
        fixed = fix_nodes_file(nodes_path, dry_run=args.dry_run)
        if fixed:
            files_fixed += 1
            total_fixed += fixed
            action = "would fix" if args.dry_run else "fixed"
            print(f"  {nodes_path.name}: {action} {fixed}")

    action = "Would fix" if args.dry_run else "Fixed"
    print(f"\n{action} {total_fixed} glosses across {files_fixed} files.")


if __name__ == "__main__":
    main()
