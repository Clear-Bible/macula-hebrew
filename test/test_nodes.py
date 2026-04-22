import pytest
import os
import codecs
import re
from lxml import etree
from test import __nodes_files__, run_xpath_for_file


@pytest.mark.parametrize("node_file", __nodes_files__)
def test_file_exists(node_file):
    size = os.path.getsize(node_file)
    assert size > 0


@pytest.mark.parametrize("node_file", __nodes_files__)
def test_file_is_valid_utf8(node_file):
    lines = codecs.open(node_file, encoding="utf-8", errors="strict").readlines()
    assert lines != ""


@pytest.mark.parametrize("node_file", __nodes_files__)
def test_file_is_valid_xml(node_file):
    assert etree.parse(node_file)


@pytest.mark.parametrize("node_file", __nodes_files__)
def test_ref_attr_correct_format(node_file):
    pattern = "^[A-Z0-9]{3} [0-9]+:[0-9]+![0-9]+$"  # USFM Ref
    nodes = run_xpath_for_file("//w", node_file)
    for node in nodes:
        assert node.attrib["ref"] != ""
        assert re.match(pattern, node.attrib["ref"])


@pytest.mark.parametrize("node_file", __nodes_files__)
def test_required_attrs_exist_on_w_elements(node_file):
    required_attrs = [
        "ref",
        "class",
        "{http://www.w3.org/XML/1998/namespace}id",  # @xml:id
        "morph",
        "unicode",
    ]
    nodes = run_xpath_for_file("//w", node_file)
    for node in nodes:
        for attr in required_attrs:
            assert attr in node.attrib


VALID_AFTER_VALUES = {" ", "־", "׃", "׀", "׃פ", "׃ס", "ס", "פ", ""}

XML_ID_PATTERN = re.compile(r"^o\d+ה?$")  # optional ה suffix for subsumed definite articles


@pytest.mark.parametrize("node_file", __nodes_files__)
def test_m_xml_id_format(node_file):
    """Every <m> element must have an xml:id of the form o<digits>."""
    XML_ID = "{http://www.w3.org/XML/1998/namespace}id"
    for m in etree.parse(node_file).xpath("//m"):
        xml_id = m.get(XML_ID, "")
        assert XML_ID_PATTERN.match(xml_id), f"Bad xml:id on <m>: {repr(xml_id)}"


@pytest.mark.parametrize("node_file", __nodes_files__)
def test_m_lemma_not_empty(node_file):
    """Every <m> element must have a non-empty @lemma."""
    bad = run_xpath_for_file("//m[not(@lemma) or @lemma='']", node_file)
    assert not bad, f"Found {len(bad)} <m> elements with missing/empty @lemma"


@pytest.mark.parametrize("node_file", __nodes_files__)
def test_m_morph_not_empty(node_file):
    """Every <m> element must have a non-empty @morph."""
    bad = run_xpath_for_file("//m[not(@morph) or @morph='']", node_file)
    assert not bad, f"Found {len(bad)} <m> elements with missing/empty @morph"


@pytest.mark.parametrize("node_file", __nodes_files__)
def test_m_after_valid_values(node_file):
    """Every @after on <m> elements must be one of the known separator values."""
    for m in etree.parse(node_file).xpath("//m[@after]"):
        after = m.get("after")
        assert after in VALID_AFTER_VALUES, (
            f"Unexpected @after value {repr(after)} on xml:id="
            f"{m.get('{http://www.w3.org/XML/1998/namespace}id')}"
        )


@pytest.mark.parametrize("node_file", __nodes_files__)
def test_last_m_in_tree_after_not_missing_or_empty(node_file):
    xpath = "//Tree/descendant::m[last()][not(@after) or @after='']"
    assert not run_xpath_for_file(xpath, node_file)


@pytest.mark.parametrize("node_file", __nodes_files__)
def test_non_final_word_last_m_has_after(node_file):
    """Last morpheme of each non-final orthographic word must have non-empty @after."""
    tree = etree.parse(node_file)
    violations = []
    for sentence in tree.xpath("//Sentence"):
        word_groups = {}
        word_order = []
        for m in sentence.iter("m"):
            w = m.get("word", "")
            if w not in word_groups:
                word_groups[w] = []
                word_order.append(w)
            word_groups[w].append(m)

        for i, word_id in enumerate(word_order):
            if i == len(word_order) - 1:
                continue  # last word in sentence is allowed empty after
            last_m = word_groups[word_id][-1]
            after = last_m.get("after", None)
            if after is None or after == "":
                xml_id = last_m.get(
                    "{http://www.w3.org/XML/1998/namespace}id", "?"
                )
                violations.append(f"word={word_id} xml:id={xml_id}")

    assert not violations, (
        f"Non-final words with empty/missing @after: {violations[:5]}"
    )


@pytest.mark.parametrize("node_file", __nodes_files__)
def test_no_cgj_anywhere(node_file):
    """CGJ (U+034F) must not appear anywhere in the file."""
    text = open(node_file, encoding="utf-8").read()
    assert "\u034f" not in text, "File contains CGJ (U+034F)"


def test_number_of_nodes_words():
    total_count = 0
    for node_file in __nodes_files__:
        count = run_xpath_for_file("//m", node_file)
        total_count += len(count)
    assert total_count == 475911
