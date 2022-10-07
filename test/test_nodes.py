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


def test_number_of_words():
    total_count = 0
    for node_file in __nodes_files__:
        count = run_xpath_for_file("//m", node_file)
        total_count += len(count)
    assert total_count == 475911
