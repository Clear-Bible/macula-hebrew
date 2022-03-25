# macula-hebrew
## Syntax trees, morphology, and linguistic annotations for the Hebrew Bible

This repository contains the MACULA linguistic datasets for Hebrew, including data from:

1. The text of the Westminster Leningrad Codex, released into the public domain by the [Groves Center](http://www.grovescenter.org/), and available at [tanach.us](tanach.us).
2. Morphology from the [Open Scriptures Hebrew Bible](https://hb.openscriptures.org), available on [Github](https://github.com/openscriptures/morphhb/).
3. Syntax trees developed by Clear Bible, Inc. together with the Groves Center. (Note: Clear was formerly known as Global Bible Initiative from 2014-2020 and Asia Bible Society before that.)  Recently, the Groves Center graciously released [Westminster Hebrew Syntax without Morphology](https://github.com/Clear-Bible/macula-hebrew/sources/groves) under a Creative Commons CC BY 4.0 license.
4. Word sense data from the United Bible Societies [MARBLE](https://semanticdictionary.org/) project.

This data has been combined into a single set of trees.  There are two variants of the these trees, found in the following directories:

1. `nodes` contains this data in a set of nested `Node` elements suitable for many NLP systems and other systems that use recursive algorithms.
2. `lowfat` contains the same data in a form more suitable for some kinds of query systems and some kinds of display.

Copyright statements for the individual sources can be found in [the MACULA Hebrew license](LICENSE.md).
