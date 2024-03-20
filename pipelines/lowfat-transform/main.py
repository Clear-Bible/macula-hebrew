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


def transform(source, dest):
    proc = PySaxonProcessor(license=False)
    proc.new_xquery_processor()
    xqueryp = proc.new_xquery_processor()
    xqueryp.run_query_to_file(
        input_file_name=str(source),
        query_file=str(REPO_ROOT / "mappings/lowfat-macula-hebrew.xquery"),
        output_file_name=str(dest),
    )


def reformat(source):
    proc = PySaxonProcessor(license=False)
    parsed = proc.parse_xml(xml_text=source.read_text())
    temp = proc.get_string_value(parsed)

    # re-insert declaration
    temp = f'<?xml version="1.0" encoding="UTF-8"?>\n{temp}'
    # re-insert newlines
    temp = temp.replace(
        '<?xml-stylesheet href="hebrew-treedown.css"?><?xml-stylesheet href="hebrew-boxwood.css"?>',
        '<?xml-stylesheet href="hebrew-treedown.css"?>\n<?xml-stylesheet href="hebrew-boxwood.css"?>\n',
    )
    # TODO: Review milestone spacing?
    temp = temp.replace("</milestone>\n", "</milestone> \n")
    source.write_text(temp)


def do_transform(input_path, output_dir):
    print(f"transforming {input_path.name}")
    dest = output_dir / f"{input_path.stem}-lowfat{input_path.suffix}"
    transform(input_path, dest)
    print(f"reformatting {dest.name}")
    reformat(dest)


def serial_transform(nodes_dir, output_dir):
    for node_path in nodes_xml_paths(nodes_dir):
        do_transform(node_path, output_dir)


def parallel_transform(nodes_dir, output_dir):
    exceptions = []
    with concurrent.futures.ProcessPoolExecutor(max_workers=MAX_WORKERS) as executor:
        deferred_tasks = {}
        for node_path in nodes_xml_paths(nodes_dir):
            deferred = executor.submit(do_transform, node_path, output_dir)
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

    lowfat_dir = REPO_ROOT / f"{edition}/lowfat"
    parallel_transform(nodes_dir, lowfat_dir)


if __name__ == "__main__":
    main()
