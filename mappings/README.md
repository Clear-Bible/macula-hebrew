# Mapping to and from MACULA Hebrew

Updated and corrected mappings between Hebrew MACULA data and UBS MARBLE data for the OT.

Rick Brannan, rick.brannan@biblica.com, 2024-04-04

# Background

**Question:** Doesn't Clear/Biblica already have data to map the Macula Hebrew identifiers to MARBLE? 

**Answer:** Well, yes, (it's [here](morpheme-mappings.xml)) but we've also recently learned that MARBLE identifiers 
had some changes and those differences are not reflected in that form of the data. So it became necessary to 
re-create the mapping using new sources.

# Data

This repository contains data that maps between `xml:id` in the Macula Hebrew data and MARBLE (UBS) identifiers. 
The data is of the following nature:

* **First, data that positively associates Macula Hebrew `xml:id` with its representative MARBLE identifier(s).** These
  may be one-to-one, one-to-many, many-to-one, or many-to-many relationships.
* **Second, data that identifies the MARBLE identifiers that are not mapped.** This allows one to better understand why
  a particular MARBLE identifier has no mapping into Macula. There are a few reasons for this, including:
  * Macula Hebrew prefers the Qere form when present. MARBLE has identifiers for both Qere and Kethiv.
  * Sometimes the text of Macula Hebrew reflects a reading from the Westminster Leningrad Codex that removed a K/Q and 
    replaced it with the text of the Kethiv. In this situation, MARBLE (reflective of BHS) still has the K/Q, and the 
    Qere reading is not present in Macula.
  * There are situations in Hebrew grammar where a definite article is assumed to be present but has no physical 
    representation in the text. MARBLE provides identifiers for these “subsumed definite articles” but we do not 
	map them in this data.

## Specifics

There are 2 verses that have alignment units that do not align between Macula and MARBLE (Hebrew)

* DAN 2:39(2x); 10:19

There are actually mappings at these points (so every term is mapped) but the words between the mappings do not
reach the threshold for similarity.

There are 29 alignment units (out of over 420,000) where the Macula and MARBLE do not agree exactly on the consonants. 
However, these areas are so similar that they are likely to each be encoding alternate (_plene_) forms of the same word.

* GEN 14:2
* JOS 15:25
* JDG 19:21
* RUT 3:14
* 1SA 25:18
* 2SA 18:8, 12
* 2KI 16:6
* NEH 5:7, 9
* JOB 6:29; 26:14; 38:12
* PSA 21:2; 140:10
* PRO 13:20
* ECC 5:17
* ISA 30:5; 42:24
* JER 5:6; 15:11; 18:16; 42:20; 48:5
* DAN 2:41; 3:18; DAN 5:7, 16(2x)


## TSV

### `tsv/macula_to_marble_map.tsv`

The first is a simple TSV file with two columns of data:

```
MACULA_IDs	MARBLE_IDs
o010010010011	00100100100002
o010010010012	00100100100004
o010010010021	00100100100006
o010010010031	00100100100008
o010010010041	00100100100010
o010010010051	00100100100012
o010010010052	00100100100014
o010010010061	00100100100016
```

Each column may have multiple space-delimited identifiers.

```
o010010120071	00100101200018
o010010120072 o010010120073	00100101200020
o010010120081	00100101200022
o010010120082	00100101200024
o010010120091	00100101200026
o010010120101	00100101200028
o010010120111	00100101200030
o010010120121 o010010120122	00100101200032
o010010120131 o010010120132	00100101200034
o010010120141	00100101200036
o010010120142 o010010120143	00100101200038
o010010120151	00100101200040
```

### `tsv/marble_unmapped.tsv`

This is another two-column TSV file. The first column is a MARBLE identifier, the second column provides the reason
the identifier is unmapped. Valid `REASON` are: `kethiv`, `qere`, `subsumed-article` and `other`. At present, the 
`other` reason is not used.

```
MARBLE_ID	REASON
00100801700052	kethiv
00101300300032	kethiv
00101400200036	kethiv
00101400800026	kethiv
00102403300002	kethiv
00102403300004	kethiv
```

## JSON

### `json/macula_to_marble_map.json`

The JSON format is the same data as `macula_to_marble.tsv`, just organized using JSON. One key difference is that it 
uses a `BCV` style identifier for a verse, and then contains a list of dictionaries of alignment units under the verse:

```
{
  "01001001": [
    {
      "macula": [
        "o010010010011"
      ],
      "marble": [
        "00100100100002"
      ]
    },
    {
      "macula": [
        "o010010010012"
      ],
      "marble": [
        "00100100100004"
      ]
    },
```

### `json/marble_unmapped.json`

The JSON format is the same data as `marble_unmapped.tsv`, just organized using JSON. This organization has the `reason`
as the organizing key, and MARBLE identifiers as a list associated with the reason. Again, Valid `reason` are: `kethiv`,
`qere`, `subsumed-article` and `other`. At present, the `other` reason is not used.

```
{
  "kethiv": [
    "00100801700052",
    "00101300300032",
    "00101400200036",

```

