import concurrent.futures
import multiprocessing
import os
from pathlib import Path
import sys

from saxonche import PySaxonProcessor


try:
    REPO_ROOT = Path(__file__).parent.parent.parent
except NameError:
    REPO_ROOT = Path(os.getcwd()).parent.parent

MAX_WORKERS = int(os.environ.get("MAX_WORKERS", multiprocessing.cpu_count() - 1))


def nodes_xml_paths(nodes_dir):
    paths = []
    for path in nodes_dir.glob("*.xml"):
        if path.name == "macula-hebrew.xml":
            continue
        paths.append(path)
    return sorted(paths)


def reformat(source):
    proc = PySaxonProcessor(license=False)
    parsed = proc.parse_xml(xml_text=source.read_text())
    temp = proc.get_string_value(parsed)

    # Strip CGJ (U+034F) — appears in OSHB source lemmas (e.g. יְרוּשָׁלִַ͏ם) but is
    # invisible, has no effect in SBL Hebrew or Ezra SIL, and should not be in lemmas.
    temp = temp.replace("\u034f", "")

    # re-insert declaration
    temp = f"<?xml version='1.0' encoding='UTF-8'?>\n{temp}"
    source.write_text(temp)


def do_reformat(input_path):
    print(f"reformatting {input_path.name}")
    reformat(input_path)


def parallel_reformat(nodes_dir):
    exceptions = []
    with concurrent.futures.ProcessPoolExecutor(max_workers=MAX_WORKERS) as executor:
        deferred_tasks = {}
        for node_path in nodes_xml_paths(nodes_dir):
            deferred = executor.submit(do_reformat, node_path)
            deferred_tasks[deferred] = node_path

        for f in concurrent.futures.as_completed(deferred_tasks):
            try:
                f.result()
            except Exception as exc:
                exceptions.append(exc)

    if exceptions:
        raise exceptions[0]


def main():
    edition = sys.argv[1]
    nodes_dir = REPO_ROOT / f"{edition}/nodes"
    assert nodes_dir.exists()

    parallel_reformat(nodes_dir)


if __name__ == "__main__":
    main()
