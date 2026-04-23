"""
Normalize all Hebrew text in WLC/nodes/*.xml to Unicode NFC.

NFC normalization reorders combining marks to canonical order (lower
combining class first). For Hebrew, this means vowel points precede
dagesh/shin-dot when on the same consonant, which is the form produced
by browsers, keyboards, and standard libraries.

NFC normalization of raw XML text is safe: all XML structural characters
are ASCII (combining class 0) and are unaffected by NFC reordering.

Usage:
    python python/normalize_nfc.py [--dry-run]
"""

import argparse
import unicodedata
from pathlib import Path

REPO_ROOT = Path(__file__).parent.parent
NODES_DIR = REPO_ROOT / "WLC" / "nodes"


def normalize_file(path, dry_run=False):
    text = path.read_text(encoding="utf-8")
    nfc = unicodedata.normalize("NFC", text)
    if nfc != text:
        if not dry_run:
            path.write_text(nfc, encoding="utf-8")
        return True
    return False


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--dry-run", action="store_true",
                        help="Report files without writing changes")
    args = parser.parse_args()

    changed = 0
    for path in sorted(NODES_DIR.glob("*.xml")):
        if path.name == "macula-hebrew.xml":
            continue
        if normalize_file(path, dry_run=args.dry_run):
            changed += 1
            action = "would normalize" if args.dry_run else "normalized"
            print(f"  {path.name}: {action}")

    action = "Would normalize" if args.dry_run else "Normalized"
    print(f"\n{action} {changed} files.")


if __name__ == "__main__":
    main()
