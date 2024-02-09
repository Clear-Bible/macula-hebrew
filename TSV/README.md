# TSV

<!-- TODO: Replace with hebrew-lowfat-to-tsv once we have resolved https://github.com/Clear-Bible/macula-hebrew/issues/65 -->
The query contained in `hebrew-nodes-to-tsv.xq` is used to generate `macula-hebrew.tsv`.

It can be ran against BaseX via the following command:

```shell
# assumes macula-hebrew repository root context
basex -i nodes/macula-hebrew.xml \
    -o TSV/macula-hebrew.tsv \
    TSV/hebrew-nodes-to-tsv.xq
```

The [csv-diff](https://pypi.org/project/csv-diff/) Python library may be useful for diffing TSVs:

```shell
# rename the existing file
mv TSV/macula-hebrew.tsv TSV/macula-hebrew-original.tsv

# run the TSV generation command as instructed above

# install csv-diff
pip3 install csv-diff

# run a diff and summarize output in JSON
csv-diff --key="xml:id" --json TSV/macula-hebrew-original.tsv \
    TSV/macula-hebrew.tsv

# optionally use JQ (https://stedolan.github.io/jq/) to get a list of changed IDs
csv-diff --key="xml:id" --json TSV/macula-hebrew-original.tsv \
    TSV/macula-hebrew.tsv \
    | jq '.changed | .[] .key' -r

# remove macula-hebrew-original.tsv
rm TSV/macula-hebrew-original.tsv
```
