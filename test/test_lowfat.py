import pytest
import os
import codecs
import re
from lxml import etree
from test import __lowfat_files__, run_xpath_for_file

XML_ID = "{http://www.w3.org/XML/1998/namespace}id"

IS_SUBSUMED_DEFINITE_ARTICLE = re.compile(r"o\d+ה")


@pytest.mark.parametrize("lowfat_file", __lowfat_files__)
def test_file_exists(lowfat_file):
    size = os.path.getsize(lowfat_file)
    assert size > 0


@pytest.mark.parametrize("lowfat_file", __lowfat_files__)
def test_file_is_valid_utf8(lowfat_file):
    lines = codecs.open(lowfat_file, encoding="utf-8", errors="strict").readlines()
    assert lines != ""


@pytest.mark.parametrize("lowfat_file", __lowfat_files__)
def test_file_is_valid_xml(lowfat_file):
    assert etree.parse(lowfat_file)


@pytest.mark.parametrize("lowfat_file", __lowfat_files__)
def test_ref_attr_correct_format(lowfat_file):
    pattern = "^[A-Z0-9]{3} [0-9]+:[0-9]+![0-9]+$"  # USFM Ref
    nodes = run_xpath_for_file("//w", lowfat_file)
    for node in nodes:
        assert node.attrib["ref"] != ""
        assert re.match(pattern, node.attrib["ref"])


@pytest.mark.parametrize("lowfat_file", __lowfat_files__)
def test_required_attrs_exist_on_w_elements(lowfat_file):
    required_attrs = [
        "ref",
        "class",
        "{http://www.w3.org/XML/1998/namespace}id",  # @xml:id
        "morph",
        "unicode",
    ]
    nodes = run_xpath_for_file("//w", lowfat_file)
    for node in nodes:
        for attr in required_attrs:
            try:
                assert node.attrib.get(attr)
            except AssertionError:
                if attr == "unicode":
                    macula_id = node.attrib.get(XML_ID)
                    if IS_SUBSUMED_DEFINITE_ARTICLE.match(macula_id):
                        continue
                raise


@pytest.mark.parametrize("lowfat_file", __lowfat_files__)
def test_no_cgj_anywhere(lowfat_file):
    """CGJ (U+034F) must not appear anywhere in the file."""
    text = open(lowfat_file, encoding="utf-8").read()
    assert "\u034f" not in text, "File contains CGJ (U+034F)"


@pytest.mark.parametrize("lowfat_file", __lowfat_files__)
def test_w_lemma_not_empty(lowfat_file):
    """Every <w> element must have a non-empty @lemma."""
    bad = run_xpath_for_file("//w[not(@lemma) or @lemma='']", lowfat_file)
    assert not bad, f"Found {len(bad)} <w> elements with missing/empty @lemma"


@pytest.mark.parametrize("lowfat_file", __lowfat_files__)
def test_w_after_not_missing(lowfat_file):
    """Every <w> element must have an @after attribute."""
    bad = run_xpath_for_file("//w[not(@after)]", lowfat_file)
    assert not bad, f"Found {len(bad)} <w> elements missing @after"


def test_number_of_lowfat_words():
    total_count = 0
    for lowfat_file in __lowfat_files__:
        count = run_xpath_for_file("//w", lowfat_file)
        total_count += len(count)
    assert total_count == 475911
