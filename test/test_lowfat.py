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
def test_no_w_elements(lowfat_file):
    """No <w> elements should appear in the lowfat output.

    The terminal unit is a morph (Haspelmath sense), represented as <m>.
    <w> was the old element name; its presence indicates an incomplete rename.
    See macula-hebrew-internal issue #20.
    """
    bad = run_xpath_for_file("//w", lowfat_file)
    assert not bad, (
        f"Found {len(bad)} <w> elements in {lowfat_file} — "
        "terminal morph elements must be <m>, not <w>"
    )


@pytest.mark.parametrize("lowfat_file", __lowfat_files__)
def test_ref_attr_correct_format(lowfat_file):
    pattern = "^[A-Z0-9]{3} [0-9]+:[0-9]+![0-9]+$"  # USFM Ref
    nodes = run_xpath_for_file("//m", lowfat_file)
    for node in nodes:
        assert node.attrib["ref"] != ""
        assert re.match(pattern, node.attrib["ref"])


@pytest.mark.parametrize("lowfat_file", __lowfat_files__)
def test_required_attrs_exist_on_m_elements(lowfat_file):
    """Every <m> (morph) element must have the required attributes."""
    required_attrs = [
        "ref",
        "class",
        "{http://www.w3.org/XML/1998/namespace}id",  # @xml:id
        "morph",
        "unicode",
    ]
    nodes = run_xpath_for_file("//m", lowfat_file)
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
def test_m_lemma_not_empty(lowfat_file):
    """Every <m> element must have a non-empty @lemma."""
    bad = run_xpath_for_file("//m[not(@lemma) or @lemma='']", lowfat_file)
    assert not bad, f"Found {len(bad)} <m> elements with missing/empty @lemma"


@pytest.mark.parametrize("lowfat_file", __lowfat_files__)
def test_m_after_not_missing(lowfat_file):
    """The last <m> of each orthographic word must have @after.

    Bound morphemes (prefix conjunctions, articles, prepositions, construct
    nouns) legitimately lack @after — they are phonologically attached to the
    following morpheme with no separator between them.  We therefore only
    require @after on word-final morphemes, identified as the last <m> with
    a given @ref value within the enclosing <sentence>.
    """
    tree = etree.parse(lowfat_file)
    violations = []
    for sentence in tree.xpath("//sentence"):
        from collections import defaultdict
        by_ref = defaultdict(list)
        for m in sentence.iter("m"):
            ref = m.get("ref")
            if ref:
                by_ref[ref].append(m)
        for ref, morphs in by_ref.items():
            last = morphs[-1]
            if last.get("after") is None:
                violations.append(f"ref={ref} xml:id={last.get(XML_ID)}")
    assert not violations, (
        f"{len(violations)} word-final <m> elements missing @after in "
        f"{lowfat_file}: {violations[:3]}"
    )


@pytest.mark.parametrize("lowfat_file", __lowfat_files__)
def test_no_pc_elements(lowfat_file):
    """No <pc> punctuation elements should appear in the lowfat output.

    Hebrew punctuation is carried on @after attributes of <m> elements,
    not split into separate <pc> nodes.
    """
    bad = run_xpath_for_file("//pc", lowfat_file)
    assert not bad, (
        f"Found {len(bad)} <pc> elements in {lowfat_file} — "
        "punctuation should be in @after, not split into <pc>"
    )


@pytest.mark.parametrize("lowfat_file", __lowfat_files__)
def test_no_error_elements(lowfat_file):
    """No <error> or <error_unknown_cat> elements should appear in the output.

    - <error> is emitted by local:morph() when a Node has unexpected children
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

    A <c> element either has a meaningful @role value or no @role attribute.
    """
    bad = run_xpath_for_file("//c[@role='']", lowfat_file)
    assert not bad, (
        f"Found {len(bad)} <c role=''> elements in {lowfat_file} — "
        "empty role string should be omitted entirely"
    )


@pytest.mark.parametrize("lowfat_file", __lowfat_files__)
def test_c_has_class(lowfat_file):
    """Every <c> (compound word) element must have @class.

    @class is the lowercase @Cat of the source Node (always 'noun' or 'adj'
    in current data). Consistent with @class on <wg> and <m> elements.
    See macula-hebrew-internal issue #18.
    """
    bad = run_xpath_for_file("//c[not(@class)]", lowfat_file)
    assert not bad, (
        f"Found {len(bad)} <c> elements without @class in {lowfat_file}"
    )


@pytest.mark.parametrize("lowfat_file", __lowfat_files__)
def test_c_children_are_m(lowfat_file):
    """<c> (compound word) elements must contain only <m> children, not <w>.

    After the <w> → <m> rename, any <c> containing <w> children indicates
    an incomplete transform. See macula-hebrew-internal issue #20.
    """
    bad = run_xpath_for_file("//c[w]", lowfat_file)
    assert not bad, (
        f"Found {len(bad)} <c> elements with <w> children in {lowfat_file} — "
        "compound children must be <m> not <w>"
    )


@pytest.mark.parametrize("lowfat_file", __lowfat_files__)
def test_wg_has_class_or_role(lowfat_file):
    """Every <wg> element must have @class or @role (or both).

    A <wg> with neither attribute is unidentifiable by downstream consumers.
    See macula-hebrew-internal issue #17.
    """
    bad = run_xpath_for_file("//wg[not(@class) and not(@role)]", lowfat_file)
    assert not bad, (
        f"Found {len(bad)} <wg> elements with neither @class nor @role "
        f"in {lowfat_file} (see internal issue #17)"
    )


def test_oshb_strongs_propagated():
    """427,616 <m> elements must carry @oshb-strongs (propagated from nodes).

    The nodes XML carries @oshb-strongs on every morph that has an OSHB
    Strong's number. 48,295 morphs (mostly pronominal suffixes and subsumed
    articles) legitimately have none. The lowfat transform must pass this
    attribute through via local:attributes(). See macula-hebrew-internal #13.
    """
    total = 0
    for lowfat_file in __lowfat_files__:
        total += len(run_xpath_for_file("//m[@oshb-strongs]", lowfat_file))
    assert total == 427616, f"Expected 427,616 <m> elements with @oshb-strongs, got {total}"


def test_number_of_lowfat_morphs():
    """Total morph count across all lowfat files must equal 475,911.

    This cross-checks with the TSV row count. <m> elements inside <c>
    (compound words) are included — //m uses the descendant axis.
    """
    total_count = 0
    for lowfat_file in __lowfat_files__:
        count = run_xpath_for_file("//m", lowfat_file)
        total_count += len(count)
    assert total_count == 475911
