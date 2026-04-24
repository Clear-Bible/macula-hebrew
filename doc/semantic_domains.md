### Semantic Domain Data

`@CoreDomain` or CoreContextualDomain: Applicable to all instances in an ET entry. It represents the primary semantic context. For example, `CoreDomain="026 050"`.

`@ContextualDomain`: Relevant to specific instances. It indicates additional semantic contexts that a term might relate to based on its usage. For example, `ContextualDomain="173"`.

`@SDBH`: These are specific IDs mapping to unique entries. It comprises several parts:
- The first six digits represent the lexicon entry number, with each entry having a unique lemma. For example, in `SDBH="001156001002000"`, `001156` is the entry number.
- The next three digits denote the base form, with multiple entries indicating different orthographically identical forms.
- The following three digits are the lexical entry for the base form. It's related to the top-down ontology paradigm/hierarchy, known as `@LexDomain`. For instance, the term 'sheep' is paradigmatically related to 'goat', 'donkey', etc., under 'domestic animals'. Example: `LexDomain="002002002005"`.
- The last three digits represent the contextual domain. These are currently all '000' in our data, as they correspond to proprietary data from MARBLE.

Please refer to the [MARBLE website](https://semanticdictionary.org/semdic.php?databaseType=SDBH&language=en#) for further details.
