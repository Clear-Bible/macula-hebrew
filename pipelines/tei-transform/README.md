# tei-transform pipeline

This pipeline will use XSLT to transform the Tanach.us XML into something resembling the macula-greek TEI.

## Requirements
- Python 3.10 or higher

## Usage:
```
cd pipelines/tei-transform
poetry install
poetry shell
python main.py
```

Pass the `--fetch` flag (e.g. `python main.py --fetch`) to re-download the book-level XML from Tanach.us before processing.
