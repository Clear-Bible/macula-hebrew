from pathlib import Path
import unicodedata

import pytest
from lxml import etree

from test import __macula_hebrew_tsv_rows__


ROOT = Path(__file__).resolve().parents[1]

EXAMPLES = [
    ("01-Gen-001", "o010010010011", "ἐν", "1722"),
    ("01-Gen-001", "o010010010012", "ἀρχῇ", "746"),
    ("01-Gen-001", "o010010010021", "ἐποίησεν", "4160"),
    ("01-Gen-001", "o010010110091", "ξύλον", "3586"),
    ("01-Gen-001", "o010010210081", "ψυχὴν", "5590"),
    ("01-Gen-001", "o010010260082", "ἰχθύων", "2486"),
    ("01-Gen-004", "o010040160012", "ἐξῆλθεν", "1831"),
    ("01-Gen-009", "o010090220112", "ἔξω", "1854"),
    ("01-Gen-029", "o010290060081", "ραχηλ", "4478"),
]


@pytest.mark.parametrize("chapter,word_id,greek,strong", EXAMPLES)
def test_nodes_greek_alignment(chapter, word_id, greek, strong):
    tree = etree.parse(str(ROOT / "WLC" / "nodes" / f"{chapter}.xml"))
    words = tree.xpath("//m[@xml:id=$word_id]", word_id=word_id)
    assert len(words) == 1
    node = words[0].getparent()
    assert unicodedata.normalize("NFC", node.attrib["Greek"]) == greek
    assert node.get("GreekStrong") == strong


@pytest.mark.parametrize("chapter,word_id,greek,strong", EXAMPLES)
def test_lowfat_greek_alignment(chapter, word_id, greek, strong):
    tree = etree.parse(str(ROOT / "WLC" / "lowfat" / f"{chapter}-lowfat.xml"))
    words = tree.xpath("//w[@xml:id=$word_id]", word_id=word_id)
    assert len(words) == 1
    assert unicodedata.normalize("NFC", words[0].attrib["greek"]) == greek
    assert words[0].get("greekstrong") == strong


@pytest.mark.parametrize("chapter,word_id,greek,strong", EXAMPLES)
def test_tsv_greek_alignment(chapter, word_id, greek, strong):
    rows = [row for row in __macula_hebrew_tsv_rows__ if row["xml:id"] == word_id]
    assert len(rows) == 1
    assert unicodedata.normalize("NFC", rows[0]["greek"]) == greek
    assert rows[0]["greekstrong"] == strong
