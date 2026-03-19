"""
Apply gloss mappings from TSV file to nodes XML files.

Uses lxml for both parsing and serialization. Run the nodes-format pipeline
afterward to restore consistent XML formatting.

Usage:
    python main.py <tsv-path> [--dry-run] [--verbose] [--filter PATTERN] [--debug] [--force]

Example:
    python main.py ../create-gloss-mapping/outputs/sil-gloss-mapping.tsv --verbose
    python main.py ../create-gloss-mapping/outputs/sil-gloss-mapping.tsv --filter "*Gen*"
    python main.py ../create-gloss-mapping/outputs/sil-gloss-mapping.tsv --debug
    python main.py ../create-gloss-mapping/outputs/sil-gloss-mapping.tsv --force
"""

import argparse
import csv
import os
import sys
from concurrent.futures import ProcessPoolExecutor, as_completed
from dataclasses import dataclass
from pathlib import Path

from lxml import etree

try:
    REPO_ROOT = Path(__file__).parent.parent.parent
except NameError:
    REPO_ROOT = Path(os.getcwd())


# XML namespace for xml:id attribute
XML_ID = "{http://www.w3.org/XML/1998/namespace}id"


@dataclass
class GlossMismatch:
    """Records a mismatch between existing and expected gloss."""

    morph_id: str
    existing: str
    expected: str


def load_gloss_mapping(tsv_path: Path, force: bool = False) -> dict[str, str]:
    """
    Load gloss mapping from TSV file.

    Args:
        tsv_path: Path to TSV file with columns: macula_id, gloss
        force: If True, include rows with empty glosses

    Returns:
        Dict mapping macula_id (with 'o' prefix) to gloss
    """
    mapping = {}

    with open(tsv_path, newline="", encoding="utf-8") as f:
        reader = csv.DictReader(f, delimiter="\t")
        for row in reader:
            macula_id = row["macula_id"]
            gloss = row["gloss"]
            if force or gloss:  # Include empty glosses when force=True
                mapping[macula_id] = gloss

    return mapping


def apply_glosses_to_file(
    nodes_file: Path,
    morph_glosses: dict[str, str],
    force: bool = False,
    dry_run: bool = False,
) -> tuple[int, int, list[GlossMismatch]]:
    """
    Apply gloss mappings to a single nodes XML file.

    Uses lxml for parsing and serialization. The nodes-format pipeline
    should be run afterward to restore consistent formatting.

    Args:
        nodes_file: Path to the nodes XML file
        morph_glosses: Dict mapping macula_id (with 'o' prefix) to gloss
        force: If True, overwrite mismatched glosses
        dry_run: If True, count changes without writing to disk

    Returns:
        Tuple of (morphs_updated, morphs_already_had_gloss, mismatches)
    """
    updated_count = 0
    already_had_count = 0
    mismatches = []

    # Parse XML
    try:
        tree = etree.parse(str(nodes_file))
    except etree.XMLSyntaxError as e:
        print(f"  WARNING: XML parse error in {nodes_file.name}: {e}")
        return 0, 0, []

    root = tree.getroot()

    # Find all <m> elements
    for m_elem in root.iter("m"):
        xml_id = m_elem.get(XML_ID)
        if not xml_id:
            continue

        if xml_id in morph_glosses:
            expected_gloss = morph_glosses[xml_id]
            existing_gloss = m_elem.get("gloss")

            should_update = False
            if existing_gloss is not None:
                already_had_count += 1
                # Check if existing gloss matches expected
                if existing_gloss != expected_gloss:
                    mismatches.append(
                        GlossMismatch(
                            morph_id=xml_id,
                            existing=existing_gloss,
                            expected=expected_gloss,
                        )
                    )
                    if force:
                        should_update = True
            else:
                should_update = True

            if should_update:
                updated_count += 1
                if not dry_run:
                    m_elem.set("gloss", expected_gloss)

    if updated_count > 0 and not dry_run:
        # Serialize with lxml (use UTF-8 bytes to include XML declaration)
        xml_bytes = etree.tostring(tree, encoding="UTF-8", xml_declaration=True)
        nodes_file.write_bytes(xml_bytes)

    return updated_count, already_had_count, mismatches


# Global variables for worker processes (set via initializer)
_worker_morph_glosses: dict[str, str] = {}


def _init_worker(morph_glosses: dict[str, str]):
    """Initialize worker process with shared data (called once per worker)."""
    global _worker_morph_glosses
    _worker_morph_glosses = morph_glosses


def _process_single_file(
    nodes_file: Path, force: bool
) -> tuple[str, int, int, list[GlossMismatch]]:
    """
    Process a single XML file. Worker function for parallel execution.

    Uses global _worker_morph_glosses which is initialized once per worker process.

    Returns:
        Tuple of (filename, updated_count, already_had_count, mismatches)
    """
    updated, already_had, mismatches = apply_glosses_to_file(
        nodes_file, _worker_morph_glosses, force
    )
    return nodes_file.name, updated, already_had, mismatches


def apply_glosses_with_filter(
    nodes_dir: Path,
    morph_glosses: dict[str, str],
    file_filter: str = "*.xml",
    verbose: bool = False,
    max_workers: int = None,
    debug: bool = False,
    dry_run: bool = False,
    force: bool = False,
) -> tuple[dict[str, tuple[int, int]], list[GlossMismatch]]:
    """
    Apply gloss mappings to nodes XML files matching a filter pattern.

    Uses parallel processing with ProcessPoolExecutor for faster execution.

    Args:
        nodes_dir: Path to directory containing nodes XML files
        morph_glosses: Dict mapping macula_id to gloss
        file_filter: Glob pattern for files to process (default: "*.xml")
        verbose: Whether to print progress
        max_workers: Maximum number of worker threads (default: None = auto)
        debug: If True, skip process pool and run sequentially
        dry_run: If True, don't write changes to files
        force: If True, overwrite mismatched glosses

    Returns:
        Tuple of:
        - Dict mapping filename to (updated_count, already_had_count)
        - List of all mismatches found
    """
    results = {}
    all_mismatches = []

    xml_files = [
        f for f in sorted(nodes_dir.glob(file_filter)) if f.name != "macula-hebrew.xml"
    ]
    total_files = len(xml_files)

    if total_files == 0:
        print(f"  No files matching '{file_filter}' found in {nodes_dir}")
        return results, all_mismatches

    if dry_run or debug:
        if verbose:
            mode = "dry run" if dry_run else "debug mode"
            print(f"  Processing {total_files} files sequentially ({mode})...")

        for i, xml_file in enumerate(xml_files, 1):
            updated, already_had, mismatches = apply_glosses_to_file(
                xml_file, morph_glosses, force, dry_run
            )

            results[xml_file.name] = (updated, already_had)
            all_mismatches.extend(mismatches)

            if verbose:
                status = f"[{i}/{total_files}] {xml_file.name}"
                if updated > 0:
                    status += f" - updated {updated}, already had {already_had}"
                if mismatches:
                    status += f" - {len(mismatches)} mismatches"
                print(status)

        return results, all_mismatches

    if verbose:
        print(
            f"  Processing {total_files} files with {max_workers or 'auto'} workers..."
        )

    completed = 0
    with ProcessPoolExecutor(
        max_workers=max_workers,
        initializer=_init_worker,
        initargs=(morph_glosses,),
    ) as executor:
        future_to_file = {
            executor.submit(_process_single_file, f, force): f for f in xml_files
        }

        for future in as_completed(future_to_file):
            filename, updated, already_had, mismatches = future.result()
            results[filename] = (updated, already_had)
            all_mismatches.extend(mismatches)
            completed += 1

            if verbose:
                status = f"[{completed}/{total_files}] {filename}"
                if updated > 0:
                    status += f" - updated {updated}, already had {already_had}"
                if mismatches:
                    status += f" - {len(mismatches)} mismatches"
                print(status)

    return results, all_mismatches


def main():
    parser = argparse.ArgumentParser(
        description="Apply gloss mappings from TSV to nodes XML files"
    )
    parser.add_argument(
        "tsv_path",
        type=Path,
        help="Path to gloss mapping TSV file (macula_id, gloss columns)",
    )
    parser.add_argument(
        "--edition", default="WLC", help="Edition to process (default: WLC)"
    )
    parser.add_argument(
        "--filter",
        "-f",
        default="*.xml",
        help="Glob pattern for files to process (default: *.xml, e.g. '*Gen*')",
    )
    parser.add_argument(
        "--dry-run", action="store_true", help="Report changes without writing to files"
    )
    parser.add_argument(
        "--verbose", "-v", action="store_true", help="Print detailed progress"
    )
    parser.add_argument(
        "--workers",
        "-w",
        type=int,
        default=None,
        help="Number of parallel workers (default: auto based on CPU count)",
    )
    parser.add_argument(
        "--debug",
        action="store_true",
        help="Run sequentially without process pool (easier debugging)",
    )
    parser.add_argument(
        "--force",
        action="store_true",
        help="Overwrite mismatched glosses and include empty-gloss rows",
    )

    args = parser.parse_args()

    if not args.tsv_path.exists():
        print(f"Error: TSV file not found: {args.tsv_path}")
        sys.exit(1)

    nodes_dir = REPO_ROOT / args.edition / "nodes"
    if not nodes_dir.exists():
        print(f"Error: Nodes directory not found: {nodes_dir}")
        sys.exit(1)

    # Step 1: Load gloss mapping
    print(f"Loading gloss mapping from {args.tsv_path}...")
    morph_glosses = load_gloss_mapping(args.tsv_path, args.force)
    print(f"  Loaded {len(morph_glosses)} gloss mappings")

    if args.dry_run:
        print("\n[DRY RUN] Analyzing changes without writing files...")

    # Step 2: Apply glosses to nodes files
    print(f"\nApplying glosses to {nodes_dir} (filter: {args.filter})...")
    results, mismatches = apply_glosses_with_filter(
        nodes_dir,
        morph_glosses,
        file_filter=args.filter,
        verbose=args.verbose,
        max_workers=args.workers,
        debug=args.debug,
        dry_run=args.dry_run,
        force=args.force,
    )

    # Summary
    total_updated = sum(r[0] for r in results.values())
    total_already_had = sum(r[1] for r in results.values())
    files_modified = sum(1 for r in results.values() if r[0] > 0)

    print("\nSummary:")
    print(f"  Files processed: {len(results)}")
    print(
        f"  Files {'would be modified' if args.dry_run else 'modified'}: {files_modified}"
    )
    print(
        f"  Morphs {'would be updated' if args.dry_run else 'updated'}: {total_updated}"
    )
    print(f"  Morphs already had gloss: {total_already_had}")
    print(f"  Gloss mismatches: {len(mismatches)}")

    if mismatches and args.verbose:
        print("\nMismatches (first 10):")
        for m in mismatches[:10]:
            print(f"  {m.morph_id}: '{m.existing}' != '{m.expected}'")

    if not args.dry_run and files_modified > 0:
        print(
            "\nNote: Run the nodes-format pipeline to restore consistent XML formatting."
        )


if __name__ == "__main__":
    main()
