import pytest
from test import __tsv_rows__


@pytest.mark.parametrize("tsv_row", __tsv_rows__)
def test_tsv_row_has_id(tsv_row):
    id = tsv_row["xml:id"]
    assert id != ""
    assert id[0] == "o"


# def test_tsv():
#     print(__tsv_rows__[1])
# for row in __tsv_rows__:
#     print(row)
