import os
import codecs
import pytest
from test import __macula_hebrew_tsv_rows__, __tsv_files__


@pytest.mark.parametrize("tsv_file", __tsv_files__)
def test_files_exists(tsv_file):
    size = os.path.getsize(tsv_file)
    assert size > 0


@pytest.mark.parametrize("tsv_file", __tsv_files__)
def test_file_is_valid_utf8(tsv_file):
    lines = codecs.open(tsv_file, encoding="utf-8", errors="strict").readlines()
    assert lines != ""


def test_tsv_row_has_id():
    for idx, tsv_row in enumerate(__macula_hebrew_tsv_rows__):
        print(idx, tsv_row)
        id = tsv_row["xml:id"]
        assert id != ""
        assert id[0] == "o"


# Expected failure.
# See: https://github.com/Clear-Bible/symphony-team/issues/207
@pytest.mark.xfail
def test_tsv_row_count():
    total_count = len(__macula_hebrew_tsv_rows__)
    assert total_count == 475911
