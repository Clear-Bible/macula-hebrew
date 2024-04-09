(:~~~ rule types ~~~:)

(: Rule types are not currently used.  Ryder had a version that relied heavily on them.  They are kept here because they may be useful. :)

(: Ryder: atomic structure rules are simple promotion/conversion rules :)
declare variable $atomic-structure-rule := ('Adj2Adjp', 'Adj2Advp', 'Adj2NP', 'Adj2Rel', 'AdjP2NP', 'Adjp2O', 'Adjp2P', 'Adjp2V', 'Adv2Adjp', 'Adv2Advp', 'Adv2Cjp', 'Adv2Pp', 'Adv2Ptcl', 'Advp2ADV', 'Advp2P', 'CL2ADV', 'CL2Adjp', 'CL2NP', 'CL2O2x', 'CL2Ox', 'CL2P', 'CL2PP', 'CL2S', 'Cj2Cjp', 'Cjp2ADV', 'Cjp2P', 'Ij2Ijp', 'Ijp2ADV', 'Ijp2advp', 'N2NP', 'N2NP', 'NP2PP', 'Np2ADV', 'Np2O', 'Np2O2', 'Np2P', 'Np2Pp', 'Np2S', 'Num2Nump', 'Nump2ADV', 'Nump2NP', 'ObjMarker', 'P2Advp', 'P2PP', 'Pp2Cjp', 'Pp2Np', 'Pp2P', 'Pp2PP', 'Pp2S', 'Pron2Adjp', 'Pron2NP', 'Ptcl2ADV', 'Ptcl2Np', 'Relp2Np', 'V2ADJP', 'V2AdvP', 'V2VP', 'VerbX', 'Vp2Np', 'Vp2V', 'VpVp2V3', 'adjp2ADV', 'adjp2O2', 'advp2np', 'cjp2np', 'cjp2pp', 'ijp2P', 'ijp2V', 'ijp2np', 'np2adjp', 'np2advp', 'np2cjp', 'np2ijp', 'np2vp', 'pp2ptcl', 'ptcl2P', 'rel2vp', 'vp2ADV');
(: Ryder: conjuncted structure rules are non-atomic rules that include conjunctions/conjunction phrases :)
declare variable $conjuncted-structure-rule := ('2CLaCL', '2CLaCLaCL', '2NpaNpaNp', '2PpaPp', '3NpaNp', '4NpaNp', 'ADJPaADJPADJPaADJP', 'ADVaADV', 'ADVaADVaADVaADV', 'AdjpAdjpandAdjp', 'AdjpaAdjp', 'AdjpandAdjpAdjp', 'AdvpaAdvp', 'AdvpandAdvp', 'AdvpandPp', 'CLa2CL', 'CLaCL', 'CjpAdjp', 'CjpAdvp2Advp', 'CjpAdvpCjpAdvp', 'ClClaClaClaClaCl', 'ClaClClaCl', 'ClaClaClCl', 'Conj11Np', 'Conj2Pp', 'Conj3Adjp', 'Conj3CL', 'Conj3Np', 'Conj3Pp', 'Conj4Adjp', 'Conj4CL', 'Conj4Np', 'Conj4Pp', 'Conj5CL', 'Conj5Np', 'Conj5Pp', 'Conj6Np', 'Conj6Pp', 'Conj7Np', 'Conj7Pp', 'Conj8Np', 'Conj9Np', 'NP10NP', 'NP3NP', 'NPNPNPNPaNPNPNPNPNPaNPNPNPNPNP', 'NPNPNPNPaNPaNPaNP', 'NPNPNPaNPNPaNP', 'NPNPNPaNPaNP', 'NPNPNPaNPaNPaNP', 'NPNPaNPNPNPNPNPaNP', 'NPNPaNPNPNPaNP', 'NPNPaNPNPaNP', 'NPNPaNPNPaNPaNP', 'NPNPaNPaNPaNP', 'NPNPaNPaNPaNPaNP', 'NPNPaNPaNPaNPaNPaNP', 'NPaNPNP', 'NPaNPNPNP', 'NPaNPNPNPNP', 'NPaNPNPNPNPNP', 'NPaNPNPNPNPNPNP', 'NPaNPNPNPNPNPaNPNP', 'NPaNPNPNPNPNPaNPaNP', 'NPaNPNPNPNPaNP', 'NPaNPNPNPaNP', 'NPaNPNPaNP', 'NPaNPNPaNPNP', 'NPaNPNPaNPNPaNP', 'NPaNPNPaNPNPaNPaNP', 'NPaNPaNPNP', 'NPaNPaNPNPNPNPNPNPNPNPNPNPNP', 'NPaNPaNPNPNPaNP', 'NPaNPaNPNPaNP', 'NPaNPaNPNPaNPNPNPaNPaNP', 'NPaNPaNPNPaNPNPaNP', 'NPaNPaNPNPaNPaNP', 'NPaNPaNPaNPNP', 'NPaNPaNPaNPNPaNP', 'NPaNPaNPaNPaNPNPNP', 'NPaNPaNPaNPaNPNPaNP', 'NPandPP2np', 'NPnp4NP', 'NPnp5NP', 'NpNp5', 'NpNp6', 'NpNpNpNpNpNpNpaNp', 'NpNpNpNpNpNpaNp', 'NpNpNpNpNpaNp', 'NpNpNpNpNpaNpNp', 'NpNpNpNpNpaNpaNp', 'NpNpNpNpaNpNpaNp', 'NpNpaNpNp', 'NpaNp', 'NumpAndNump', 'NumpNumpNumpaNump', 'NumpNumpaNump', 'NumpNumpaNumpaNump', 'NumpaNumpNump', 'NumpaNumpNumpaNump', 'NumpaNumpaNump', 'NumpaNumpaNumpaNump', 'PP8PP', 'PP9PP', 'PPPP4', 'PPPP5', 'PPandPP', 'PpPp9', 'PpPpPpPpandPp', 'PpPpPpaPpaPpaPpaPp', 'PpPpPpandPp', 'PpPpPpandPpPp', 'PpPpaPpaPpaPp', 'PpPpandPpPp', 'PpaPpPpPpPpaPp', 'PpaPpPpaPp', 'PpandAdvp', 'PpandPpPp', 'Relp3Relp', 'Relp5Relp', 'RelpandRelp', 'VP3VP', 'VPandVP', 'aCLaCL', 'aCLaCLaCL', 'aNpaNp', 'aNpaNpaNp', 'aPpaPp', 'aPpaPpaPp', 'cjpNp', 'cjpPp', 'ppPP5PP', 'ppPP6PP', 'ppappPP5PP');
(: Ryder: "groups" repeat the same structure multiple times. This test could probably be nuanced a bit more (e.g., should any of these have heads?) :)
declare variable $group-rule := ('12Np', '2Advp_h1', '2Advp_h2', '2CLaCL', '2CLaCLaCL', '2Np', '2NpaNpaNp', '2Pp', '2Pp', '2PpaPp', '3Adjp', '3NpaNp', '4NpaNp', '7Np', 'ADJPaADJPADJPaADJP', 'ADVaADV', 'ADVaADVaADVaADV', 'AdjpAdjp', 'AdjpAdjpandAdjp', 'AdjpaAdjp', 'AdjpandAdjpAdjp', 'AdvpaAdvp', 'AdvpandAdvp', 'CLa2CL', 'CLaCL', 'CjpAdvpCjpAdvp', 'CjpCjp', (:'ClCl', 'ClCl2', :) 'ClClCl', 'ClClClCl', 'ClClClClCl', 'ClClClClClCl', 'ClClaClaClaClaCl', 'ClaClClaCl', 'ClaClaClCl', 'Conj11Np', 'Conj2Pp', 'Conj3Adjp', 'Conj3CL', 'Conj3Np', 'Conj3Pp', 'Conj4Adjp', 'Conj4CL', 'Conj4Np', 'Conj4Pp', 'Conj5CL', 'Conj5Np', 'Conj5Pp', 'Conj6Np', 'Conj6Pp', 'Conj7Np', 'Conj7Pp', 'Conj8Np', 'Conj9Np', 'IjpIjp', 'NP10NP', 'NP3NP', 'NPNPNPNPaNPNPNPNPNPaNPNPNPNPNP', 'NPNPNPNPaNPaNPaNP', 'NPNPNPaNPNPaNP', 'NPNPNPaNPaNP', 'NPNPNPaNPaNPaNP', 'NPNPaNPNPNPNPNPaNP', 'NPNPaNPNPNPaNP', 'NPNPaNPNPaNP', 'NPNPaNPNPaNPaNP', 'NPNPaNPaNPaNP', 'NPNPaNPaNPaNPaNP', 'NPNPaNPaNPaNPaNPaNP', 'NPaNPNP', 'NPaNPNPNP', 'NPaNPNPNPNP', 'NPaNPNPNPNPNP', 'NPaNPNPNPNPNPNP', 'NPaNPNPNPNPNPaNPNP', 'NPaNPNPNPNPNPaNPaNP', 'NPaNPNPNPNPaNP', 'NPaNPNPNPaNP', 'NPaNPNPaNP', 'NPaNPNPaNPNP', 'NPaNPNPaNPNPaNP', 'NPaNPNPaNPNPaNPaNP', 'NPaNPaNPNP', 'NPaNPaNPNPNPNPNPNPNPNPNPNPNP', 'NPaNPaNPNPNPaNP', 'NPaNPaNPNPaNP', 'NPaNPaNPNPaNPNPNPaNPaNP', 'NPaNPaNPNPaNPNPaNP', 'NPaNPaNPNPaNPaNP', 'NPaNPaNPaNPNP', 'NPaNPaNPaNPNPaNP', 'NPaNPaNPaNPaNPNPNP', 'NPaNPaNPaNPaNPNPaNP', 'NPnp4NP', 'NPnp5NP', 'Np5Np', 'NpNp5', 'NpNp6', 'NpNpNp', 'NpNpNp11', 'NpNpNpNp', 'NpNpNpNpNp', 'NpNpNpNpNpNp', 'NpNpNpNpNpNpNpaNp', 'NpNpNpNpNpNpaNp', 'NpNpNpNpNpaNp', 'NpNpNpNpNpaNpNp', 'NpNpNpNpNpaNpaNp', 'NpNpNpNpaNpNpaNp', 'NpNpaNpNp', 'NpaNp', 'PP8PP', 'PP9PP', 'PPPP4', 'PPPP5', 'PPandPP', 'PpPp', 'PpPp9', 'PpPpPp', 'PpPpPpPp', 'PpPpPpPpPp', 'PpPpPpPpandPp', 'PpPpPpaPpaPpaPpaPp', 'PpPpPpandPp', 'PpPpPpandPpPp', 'PpPpaPpaPpaPp', 'PpPpandPpPp', 'PpaPpPpPpPpaPp', 'PpaPpPpaPp', 'PpandPpPp', 'Relp3Relp', 'Relp5Relp', 'RelpandRelp', 'VP3VP', 'VPandVP', 'aNpaNp', 'aNpaNpaNp', 'aPpaPp', 'aPpaPpaPp', 'ppPP5PP', 'ppPP6PP', 'ppappPP5PP', 'RelpRelp', 'aCLaCL', 'aCLaCLaCL', 'NumpAndNump', 'NumpNump', 'NumpNumpNumpNump', 'NumpNumpNumpaNump', 'NumpNumpaNump', 'NumpNumpaNumpaNump', 'NumpaNumpNump', 'NumpaNumpNumpaNump', 'NumpaNumpaNump', 'NumpaNumpaNumpaNump');
(: Ryder: modifier structures are headed structures that have rules realized by diverse structural patterns (i.e., comprising mixed types of structures beyond simply conjunctions and repetitions of the same structure) :)
(: Ryder TODO: modifier structure rules need to be broken down into two groups:
    1. those that already have a proper dependency structure, and
    2. those that only group constituents without indicating modifier dependency structure
    :)
declare variable $modifier-structure-rule := ('AdjX', 'AdjpAdvp', 'AdjpNp', 'AdjpPp', 'AdjpofNp', 'AdvX', 'AdvpAdjp', 'AdvpCL', 'AdvpNp', 'AdvpNp2advp', 'AdvpNump', 'AdvpPp', 'AdvpPp2', 'AdvpRelp', 'AdvpandPp', 'CjpAdjp', 'CjpAdvp2Advp', 'IjpX', 'NPandPP2np', 'NounX', 'NpAdjp', 'NpAdvp', 'NpCL', 'NpInf', 'NpNump', 'NpPart', 'NpPp', 'NpRelp', 'NumX', 'NumpAdjp', 'NumpNP', 'NumpPp', 'OmpNP', 'OmpRelp', 'PpAdvp', 'PpNp2Np', 'PpNump', 'PpNump2', 'PpRelp', 'PpandAdvp', 'PrepCL', 'PrepNp', 'PrepX', 'PtclCL', 'RelpNp', 'VerbX', 'advpCLtoAdvp', 'cjpCLx', 'relNp', 'NPofNP');
(: Ryder: complex clauses are clauses (i.e., @Cat='CL') that do not have clause-function rules (e.g., 'S-V-O'). Note that you still need to check whether the node with the @Rule is indeed @Cat='CL', since these rules can show up elsewhere. :)
declare variable $complex-clause-rule := ('2CLaCL', '2CLaCLaCL', 'CLa2CL', 'CLandCL2', 'ClCl', 'ClCl2', 'aCLaCL', 'aCLaCLaCL', 'cjpCLx', 'ppCL', 'NpCL', 'NpInf', 'NpPart');
(: Ryder: wrapper clause rules are a subset of complex clause rules. They involve "wrapper" scope of the initial marker over a clause. 'ppCL' for example are typically subordinate clauses with a preposition marker. :)
declare variable $wrapper-clause-rule := ('AdvpCL', 'cjpCLx', 'PtclCL', 'ppCL', 'relCL');
(: Ryder: general wrapper rules are just like wrapper clause rules, but they involve wrapping of any non-clause unit. :)
declare variable $wrapper-rule := ('cjpNp', 'cjpPp', 'QuanNP');

declare variable $apposition-rule := ('Np-Appos');
declare variable $auxiliary-rule := ('ADV2CL', 'Intj2CL', 'Np2CL', 'P2CL', 'O22CL', 'O2CL', 'S2CL', 'V2CL', 'Relp2CL', 'PP2CL');
(: 

Ryder notes:

- 'aCLaCL' (but not 'aCLaCLaCL', which has one instance) includes many 'if x or y' constructions. Some of these could be analyzed as wrappers wrapping junction. They should then be removed from $group-rule.
- 'CLa2CL' includes some apparent clause complexes (e.g., JOS 10:1), whereas others seem to be independant clauses. I assume '2CLaCL' is not the same, since it does no involve promotion to a clause.

:)
declare variable $aramaic-determiner-rule := ('NPDet', 'NumpDet', 'AdjpDet');
declare variable $hebrew-determiner-rule := ('DetAdjp', 'DetNP', 'DetNump', 'DetVp');
declare variable $aramaic-structure-rule := ('vpVp2V2', 'Vpvp2V1');
declare variable $nominalized-clause-rule := ('CL2Adjp', 'CL2NP');
declare variable $single-constituent-clause-rule := ('ADV2CL', 'Np2CL', 'Intj2CL', 'O22CL', 'O2CL', 'P2CL', 'PP2CL', 'Relp2CL', 'S2CL', 'V2CL');


(: verse functions :)

declare function local:USFMBook($nodeId)
{
	if (string-length($nodeId) < 1)
	then
		"error5"
	else
		switch (xs:integer(substring($nodeId, 1, 2)))
			case 01
				return
					"GEN"
			case 02
				return
					"EXO"
			case 03
				return
					"LEV"
			case 04
				return
					"NUM"
			case 05
				return
					"DEU"
			case 06
				return
					"JOS"
			case 07
				return
					"JDG"
			case 08
				return
					"RUT"
			case 09
				return
					"1SA"
			case 10
				return
					"2SA"
			case 11
				return
					"1KI"
			case 12
				return
					"2KI"
			case 13
				return
					"1CH"
			case 14
				return
					"2CH"
			case 15
				return
					"EZR"
			case 16
				return
					"NEH"
			case 17
				return
					"EST"
			case 18
				return
					"JOB"
			case 19
				return
					"PSA"
			case 20
				return
					"PRO"
			case 21
				return
					"ECC"
			case 22
				return
					"SNG"
			case 23
				return
					"ISA"
			case 24
				return
					"JER"
			case 25
				return
					"LAM"
			case 26
				return
					"EZK"
			case 27
				return
					"DAN"
			case 28
				return
					"HOS"
			case 29
				return
					"JOL"
			case 30
				return
					"AMO"
			case 31
				return
					"OBA"
			case 32
				return
					"JON"
			case 33
				return
					"MIC"
			case 34
				return
					"NAM"
			case 35
				return
					"HAB"
			case 36
				return
					"ZEP"
			case 37
				return
					"HAG"
			case 38
				return
					"ZEC"
			case 39
				return
					"MAL"
			default return
				"###"
};

declare function local:USFMVerseId($nodeId)
{
	if (string-length($nodeId) < 1)
	then
		"error7"
	else
		concat(local:USFMBook($nodeId),
		" ",
		xs:integer(substring($nodeId, 3, 3)),
		":",
		xs:integer(substring($nodeId, 6, 3))
		)
};

declare function local:attributes($node)
(: FIXME: 
    1. Exclusions doesn't seem to be used - simplify?
    2. Conditional logic seems unnecessary here - simplify?
:)
{
    (: `m` attributes :)
	$node/@xml:id,
	$node/@mandarin,
	$node/@english,
	$node/@morph,
	$node/@pos,
	$node/@after,
	$node/@type,
	$node/@gloss,
	$node/@transliteration,
	$node/@word ! attribute ref {.},
	$node/@SDBH ! attribute sdbh {.},
	$node/@lemma ! attribute stronglemma {.},
	$node/@LexDomain ! attribute lexdomain {.},
	$node/@ContextualDomain ! attribute contextualdomain {.},
	$node/@CoreDomain ! attribute coredomain {.},
	$node/parent::Node/@SenseNumber ! attribute sensenumber {.},
	$node/parent::Node/@Frame ! attribute frame {.},
	$node/parent::Node/@Ref ! attribute participantref {.},
	$node/parent::Node/@SubjRef ! attribute subjref {.},
	$node/parent::Node/@Greek ! attribute greek {.},
	$node/parent::Node/@GreekStrong ! attribute greekstrong {.},
	$node/parent::Node/@StrongNumberX ! attribute strongnumberx {.},
	$node/parent::Node/@Unicode ! attribute unicode {.},
		
	if ($node/@Cat) then
		attribute class {lower-case($node/@Cat)}
	else
		attribute class {lower-case($node/parent::Node/@Cat)},
			
	$node/@Rule ! attribute rule {.},
	$node/@Unicode ! attribute unicode {.},
	$node/@lang ! attribute lang {.},
	$node/@lemma ! attribute lemma {.},
	$node/@gender ! attribute gender {lower-case(.)},
	$node/@number ! attribute number {lower-case(.)},
	$node/@state ! attribute state {lower-case(.)},
	$node/@stem ! attribute stem {lower-case(.)},
	$node/@person ! attribute person {lower-case(.)},
	$node/@StrongNumberX ! attribute strongnumberx {.},
	$node/@Greek ! attribute greek {.},
	
	(: Ryder: FIXME: where exactly do we want this articular rule to go? Should we make it a discontinuous subordination phrase? :)
	if ($node/@Rule = $aramaic-determiner-rule) then
		attribute articular {'true'}
	else
		(),
	if ($node/@Rule = $nominalized-clause-rule) then
		attribute clausetype {'nominalized-clause'}
	else
		(),
		
	let $head := $node/parent::Node/@Head + 1
	let $headNode := $node/parent::Node/*[$head]
	where $node is $headNode
	return attribute head { true() }
};


declare function local:is-worth-preserving($clause)
{
    local:node-type($clause/parent::*) = 'role'
    or $clause/@Rule='sub-CL'
    or not($clause/@Rule=('ClCl','ClCl2'))
};

declare function local:oneword($node)
(: If the Node governs a single word, return that word. :)
{
     if (count($node/Node) > 1)
     then ()
     else if ($node/Node)
     then local:oneword($node/Node)
     else $node
};

declare function local:clause($node)
(:  This is probably too simple as written - could do restructuring of clauses based on @rule attributes  :)
{
      if (local:is-worth-preserving($node))
      then       
        <wg>
          {
              local:attributes($node),
              $node/Node ! local:node(.)
          }
        </wg>
      else 
        $node/Node ! local:node(.) 
};


declare function local:phrase($node)
{
    if (local:oneword($node))
    then (local:word(local:oneword($node)))
    else
        <wg>
          {
            local:attributes($node),
            $node/Node ! local:node(.)
          }
        </wg>
};

declare function local:role($node)
(:
  A role node can have more than one child in some
  corner cases in the GBI trees, e.g. Gal 4:18, where
  an ADV node contains ADV conj ADV.  I imagine this
  occurs only for conjunctions, but I am not sure.
:)
{
    let $role := 
        if ($node/parent::Tree)
        then ()
        else attribute role {lower-case($node/@Cat)}
    return
        if (local:oneword($node))
        then (local:word(local:oneword($node), $role))
        else  if (count($node/Node) > 1)
        then
            <wg>
                {
                    $role,
                    $node/Node ! local:node(.)
                }
            </wg>
        else
            <wg>
                {
                    $role,
                    local:attributes($node/Node),
                    $node/Node/Node ! local:node(.)
                }
            </wg>
};

declare function local:word($node)
{
    local:word($node, ())
};

declare function local:word($node, $role)
(: $role can contain a role attribute or a null sequence :)
{
    if ($node/c) then <c role="{$role}">{  $node/c/m ! local:word(.)}</c>
    else if ($node/m)
    then local:word($node/m, $role)
    else if ($node/*) then ( element error {$role, $node }) 
    else if (substring($node, string-length($node), 1) = ( "·", " .", ";", ",",".","—","·",";"))
    then
        (: place punctuation in a separate node :)
        (
        <w>
            {
                $role,
                local:attributes($node),
                substring($node, 1, string-length($node) - 1)
            }
        </w>,<pc>{substring($node, string-length($node), 1)}</pc>
        )
    else
        <w>
            {
                $role,
                local:attributes($node),
                string($node)
            }
        </w>
};

declare function local:node-type($node as element(Node))
{
    if ($node/m)
      then "word"
    else
    switch ($node/@Cat)
        case "adj"
        case "adv"
        case "art"
        case "conj"
        case "det"
        case "noun"
        case "num"
        case "prep"
        case "ptcl"
        case "pron"
        case "verb"
        case "intj"
	    case "adjp"
        case "advp"
        case "np"
        case "nump"
        case "pp"
        case "vp"
        (:  the following were found using //@Cat, not sure what they all are ... :)
        case "omp"
        case "om"
        case "cjp"
        case "cj"
        case "relp"
        case "rel"
        case "ijp"
        case "ij"
        case "x"
            return
                "phrase"
        case "S"
        case "IO"
        case "ADV"
        case "O"
        case "O2"
        case "P"
        case "PP"
        case "V"
        case "VC"
            return
                "role"
        case "CL"
            return
                "clause"
        default
        return "####"
};

(:

:)


declare function local:node($node as element(Node))
{
    switch (local:node-type($node))
        case "word"
            return
                local:word($node)
        case "phrase"
            return
                local:phrase($node)
        case "role"
            return
                local:role($node)
        case "clause"
            return
                local:clause($node)
        default
        return
            $node
};

declare function local:straight-text($node)
{
    let $strings :=
        for $m in $node//m
        order by $m/@xml:id
        return concat($m/text(), $m/@after)
    return 
        string-join($strings,"")
};

declare function local:sentence($node)
{
	<sentence>
		{	
			attribute id {$node/ancestor::Sentence/@verse},
			<p>
				{
					for $verse in distinct-values($node//Node/@morphId ! local:USFMVerseId(.))
					return
						(
						<milestone
							unit="verse">
							{attribute id {$verse}, $verse}
						</milestone>
						,
						" "
						)
				}
				{ local:straight-text($node) }
			</p>,
			local:node($node)
			
		}
	</sentence>
};

(:~~~ execution ~~~:)

(:processing-instruction xml-stylesheet {'href="../../macula-greek/Nestle1904/lowfat/treedown.css"'},:)
processing-instruction xml-stylesheet {'href="hebrew-treedown.css"'},
processing-instruction xml-stylesheet {'href="hebrew-boxwood.css"'},
<chapter 
	lang="he"
	id="{(/descendant::Sentence)[1]/substring(@verse, 1, 5)}">
	{
	(:
            If a sentence has multiple interpretations, Sentence/Trees may contain
            multiple Tree nodes.  The first is the preferred interpretation.
        :)
	
		for $sentence in //Tree[1]/Node
		return
			local:sentence($sentence)
	}
</chapter>
