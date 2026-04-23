import os
import codecs
import re
import unicodedata
import pytest
from test import __macula_hebrew_tsv_rows__, __tsv_files__


REF_PATTERN = re.compile(r"^[A-Z0-9]{3} [0-9]+:[0-9]+![0-9]+$")
XML_ID_PATTERN = re.compile(r"^o\d+ה?$")  # optional ה suffix for subsumed definite articles
VALID_AFTER_VALUES = {" ", "־", "׃", "׀", "׃פ", "׃ס", "ס", "פ", ""}


@pytest.mark.parametrize("tsv_file", __tsv_files__)
def test_files_exists(tsv_file):
    size = os.path.getsize(tsv_file)
    assert size > 0


@pytest.mark.parametrize("tsv_file", __tsv_files__)
def test_file_is_valid_utf8(tsv_file):
    lines = codecs.open(tsv_file, encoding="utf-8", errors="strict").readlines()
    assert lines != ""


def test_tsv_no_cgj():
    """CGJ (U+034F) must not appear anywhere in the TSV."""
    with open("../WLC/tsv/macula-hebrew.tsv", encoding="utf-8") as f:
        content = f.read()
    assert "\u034f" not in content, "TSV contains CGJ (U+034F)"


def test_tsv_is_nfc():
    """All text in the TSV must be Unicode NFC."""
    with open("../WLC/tsv/macula-hebrew.tsv", encoding="utf-8") as f:
        content = f.read()
    assert unicodedata.normalize("NFC", content) == content, "TSV contains non-NFC text"


def test_tsv_row_has_id():
    for tsv_row in __macula_hebrew_tsv_rows__:
        id = tsv_row["xml:id"]
        assert id != ""
        assert id[0] == "o"


def test_tsv_xml_id_format():
    for tsv_row in __macula_hebrew_tsv_rows__:
        assert XML_ID_PATTERN.match(tsv_row["xml:id"]), (
            f"Bad xml:id: {repr(tsv_row['xml:id'])}"
        )


def test_tsv_ref_format():
    for tsv_row in __macula_hebrew_tsv_rows__:
        assert REF_PATTERN.match(tsv_row["ref"]), (
            f"Bad ref: {repr(tsv_row['ref'])}"
        )


def test_tsv_after_valid_values():
    for tsv_row in __macula_hebrew_tsv_rows__:
        after = tsv_row["after"]
        assert after in VALID_AFTER_VALUES, f"Unexpected after value: {repr(after)}"


def test_tsv_lemma_not_empty():
    for tsv_row in __macula_hebrew_tsv_rows__:
        assert tsv_row["lemma"], f"Empty lemma for {tsv_row['xml:id']}"


def test_tsv_row_count():
    total_count = len(__macula_hebrew_tsv_rows__)
    assert total_count == 475911
