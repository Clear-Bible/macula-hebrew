import pytest
import os
import codecs
import re
import unicodedata
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
def test_file_is_nfc(lowfat_file):
    """All text in the file must be Unicode NFC."""
    text = open(lowfat_file, encoding="utf-8").read()
    assert unicodedata.normalize("NFC", text) == text, "File contains non-NFC text"


@pytest.mark.parametrize("lowfat_file", __lowfat_files__)
def test_no_cgj_anywhere(lowfat_file):
    """CGJ (U+034F) must not appear anywhere in the file."""
    text = open(lowfat_file, encoding="utf-8").read()
    assert "\u034f" not in text, "File contains CGJ (U+034F)"


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
def test_w_lemma_not_empty(lowfat_file):
    """Every <w> element must have a non-empty @lemma."""
    bad = run_xpath_for_file("//w[not(@lemma) or @lemma='']", lowfat_file)
    assert not bad, f"Found {len(bad)} <w> elements with missing/empty @lemma"


@pytest.mark.parametrize("lowfat_file", __lowfat_files__)
def test_w_after_not_missing(lowfat_file):
    """The last <w> of each orthographic word must have @after.

    Bound morphemes (prefix conjunctions, articles, prepositions, construct
    nouns) legitimately lack @after — they are phonologically attached to the
    following morpheme with no separator between them.  We therefore only
    require @after on word-final morphemes, identified as the last <w> with
    a given @ref value within the enclosing <sentence>.
    """
    tree = etree.parse(lowfat_file)
    violations = []
    for sentence in tree.xpath("//sentence"):
        from collections import defaultdict
        by_ref = defaultdict(list)
        for w in sentence.iter("w"):
            ref = w.get("ref")
            if ref:
                by_ref[ref].append(w)
        for ref, words in by_ref.items():
            last = words[-1]
            if last.get("after") is None:
                violations.append(f"ref={ref} xml:id={last.get(XML_ID)}")
    assert not violations, (
        f"{len(violations)} word-final <w> elements missing @after in "
        f"{lowfat_file}: {violations[:3]}"
    )


@pytest.mark.parametrize("lowfat_file", __lowfat_files__)
def test_no_pc_elements(lowfat_file):
    """No <pc> punctuation elements should appear in the lowfat output.

    Hebrew punctuation is carried on @after attributes of <m>/<w> elements,
    not split into separate <pc> nodes. The punctuation-splitting branch in
    local:word() (copied from Greek) is dead code in Hebrew context.
    """
    bad = run_xpath_for_file("//pc", lowfat_file)
    assert not bad, (
        f"Found {len(bad)} <pc> elements in {lowfat_file} — "
        "punctuation should be in @after, not split into <pc>"
    )


@pytest.mark.parametrize("lowfat_file", __lowfat_files__)
def test_no_error_elements(lowfat_file):
    """No <error> or <error_unknown_cat> elements should appear in the output.

    - <error> is emitted by local:word() when a Node has unexpected children
      (neither <m> nor <c>).
    - <error_unknown_cat> is emitted by local:node() when a Node has a @Cat
      value not handled by local:node-type() (the '####' fallback).

    Either element in the output signals an unhandled case in the transform.
    """
    bad = run_xpath_for_file("//error | //error_unknown_cat", lowfat_file)
    assert not bad, (
        f"Found {len(bad)} error element(s) in {lowfat_file} — "
        "unhandled node structure in lowfat transform"
    )


@pytest.mark.parametrize("lowfat_file", __lowfat_files__)
def test_c_role_not_empty_string(lowfat_file):
    """<c> (compound word) elements must not have role='' (empty string).

    local:word() produces <c> for compound words.  When no role is passed,
    the XQuery empty-sequence-to-string coercion must NOT produce role=''.
    A <c> element either has a meaningful @role value or no @role attribute.
    """
    bad = run_xpath_for_file("//c[@role='']", lowfat_file)
    assert not bad, (
        f"Found {len(bad)} <c role=''> elements in {lowfat_file} — "
        "empty role string should be omitted entirely"
    )


@pytest.mark.parametrize("lowfat_file", __lowfat_files__)
def test_wg_has_class_or_role(lowfat_file):
    """Every <wg> element must have @class or @role (or both).

    A <wg> with neither attribute is unidentifiable by downstream consumers.
    The known gap is sentence-root role nodes with multiple children (see
    internal issue #17): local:role() emits no @class when the parent is Tree.
    This test documents the current state; once #17 is resolved, all <wg>
    elements should have @class.
    """
    bad = run_xpath_for_file("//wg[not(@class) and not(@role)]", lowfat_file)
    assert not bad, (
        f"Found {len(bad)} <wg> elements with neither @class nor @role "
        f"in {lowfat_file} (see internal issue #17)"
    )


def test_number_of_lowfat_words():
    total_count = 0
    for lowfat_file in __lowfat_files__:
        count = run_xpath_for_file("//w", lowfat_file)
        total_count += len(count)
    assert total_count == 475911
