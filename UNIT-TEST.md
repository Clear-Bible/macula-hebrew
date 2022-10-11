# Development Guide

## Testing

[`pytest`](https://docs.pytest.org/) is used to run tests to verify data correctness.
All tests in the suite must pass in a branch before a pull request can be merged.
Along with a core set of tests to catch basic regressions,
pull requests for new features or fixes are expected to have accompanying unit tests that demonstrate the correctness of the change.

### Writing tests
In aiming to keep tests readable and succinct, there are some preset patterns and helpers available to those writing tests.

#### Available files
Lists of expected file paths are created in `test/__init__.py`.
Tests can use these expected file paths as test targets.
File path lists can be imported like so:

```python
from test import __nodes_files__
from test import __lowfat_files__
```

#### Parameterized Tests
[`pytest`](https://docs.pytest.org/) offers decorators that allow a single test to be parameterized across a set of files. This allows us to write a single test that can be applied to all of the files in a dataset. When a failure occurs, [`pytest`]() prints of the condition failure and the parameter that the test failed on.

Example: this test will run for each file defined in the `__nodes_files__` list:

```python
@pytest.mark.parametrize("nodes_file", __nodes_files__)
def test_file_is_valid_xml(nodes_file):
    assert etree.parse(nodes_file)
```

#### Additional Helpers

##### `run_xpath_for_file`

Takes an xpath expression and a file path.
Returns a list of elements matched by the expression.

### Running the test suite locally

Prerequisites:

* Python 3.x
* Poetry (dependency management for python)

In the project root, install dependencies:

```shell
poetry install
```

Run all tests:

```shell
poetry run pytest
```

Run a specific test file:

```shell
poetry run pytest test/test_lowfat.py
```

Run the tests with console output:

```shell
poetry run pytest -rP
```
