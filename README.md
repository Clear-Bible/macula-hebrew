# macula-hebrew (מכלה)
## Syntax trees, morphology, and linguistic annotations for the Hebrew Bible

This repository contains the MACULA linguistic datasets for the Hebrew Bible, including data from:

1. **_The text of the Westminster Leningrad Codex_**, released into the public domain by the [Groves Center](http://www.grovescenter.org/), and available at [tanach.us](http://tanach.us).
2. **_Morphology_** from the [Open Scriptures Hebrew Bible](https://hb.openscriptures.org), available on [Github](https://github.com/openscriptures/morphhb/).
3. **_Syntax trees_** developed by Clear Bible, Inc. together with the Groves Center. (Note: Clear was formerly known as Global Bible Initiative from 2014-2020 and Asia Bible Society before that.)  Recently, the Groves Center graciously released [Westminster Hebrew Syntax without Morphology](https://github.com/Clear-Bible/macula-hebrew/tree/main/sources/GrovesCenter) under a Creative Commons CC BY 4.0 license.
4. **_Word sense data_** from the United Bible Societies [MARBLE](https://semanticdictionary.org/) project, based on the Semantic Dictionary of Biblical Hebrew.
5. **_Cherith Glosses for the Hebrew Old Testament_**, by Andi Wu, Copyright (C) 2022 by Cherith Analytics, is licensed under a  [Creative Commons Attribution 4.0 International License ("CC BY 4.0")](https://creativecommons.org/licenses/by/4.0/).
6. **_Semantic roles_**: Who does what to whom? (Agent, Verb, Patient …)
7. **_Participant referents_**: Who is “he,” “she,” or “it” in this sentence?

We are adding further datasets, one at a time.

This data has been combined into a single set of trees. There are three variants of this data, found in the following directories:

1. `nodes` contains this data in a set of nested `Node` elements suitable for many NLP systems and other systems that use recursive algorithms.
2. `lowfat` contains the same data in a form more suitable for some kinds of query systems and some kinds of display.
3. `TSV` contains the word-level data in a TSV table, without syntactic tree structure. This is simpler for many programs that do not need the complexity of graph structures.

Copyright statements for the individual sources can be found in [the MACULA Hebrew license](LICENSE.md).
