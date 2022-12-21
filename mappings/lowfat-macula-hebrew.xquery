(:~~~ rule types ~~~:)

(: Ryder: atomic structure rules are simple promotion/conversion rules :)
declare variable $atomic-structure-rule := ('Adj2Adjp', 'Adj2Advp', 'Adj2NP', 'Adj2Rel', 'AdjP2NP', 'Adjp2O', 'Adjp2P', 'Adjp2V', 'Adv2Adjp', 'Adv2Advp', 'Adv2Cjp', 'Adv2Pp', 'Adv2Ptcl', 'Advp2ADV', 'Advp2P', 'CL2ADV', 'CL2Adjp', 'CL2NP', 'CL2O2x', 'CL2Ox', 'CL2P', 'CL2PP', 'CL2S', 'Cj2Cjp', 'CjpCjp', 'Cjp2ADV', 'Cjp2P', 'Ij2Ijp', 'Ijp2ADV', 'Ijp2advp', 'N2NP', 'N2NP', 'NP2PP', 'Np2ADV', 'Np2O', 'Np2O2', 'Np2P', 'Np2Pp', 'Np2S', 'Num2Nump', 'Nump2ADV', 'Nump2NP', 'ObjMarker', 'P2Advp', 'P2PP', 'Pp2Cjp', 'Pp2Np', 'Pp2P', 'Pp2PP', 'Pp2S', 'Pron2Adjp', 'Pron2NP', 'Ptcl2ADV', 'Ptcl2Np', 'Relp2Np', 'V2ADJP', 'V2AdvP', 'V2VP', 'VerbX', 'Vp2Np', 'Vp2V', 'VpVp2V3', 'adjp2ADV', 'adjp2O2', 'advp2np', 'cjp2np', 'cjp2pp', 'ijp2P', 'ijp2V', 'ijp2np', 'np2adjp', 'np2advp', 'np2cjp', 'np2ijp', 'np2vp', 'pp2ptcl', 'ptcl2P', 'rel2vp', 'vp2ADV');
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
declare variable $complex-clause-rule := ('2CLaCL', '2CLaCLaCL', 'CLa2CL', 'CLandCL2', 'ClCl', 'ClCl2', 'aCLaCL', 'aCLaCLaCL', 'cjpCLx', 'ppCL', 'AdvpCL', 'PtclCL');
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
declare variable $hebrew-determiner-rule := ('DetAdjp', 'DetNP', 'DetNump', 'DetVp'); (: Ryder: The dependency tree for these are handled nicely in the GBI trees already. :)
declare variable $aramaic-structure-rule := ('vpVp2V2', 'Vpvp2V1');
declare variable $nominalized-clause-rule := ('CL2Adjp', 'CL2NP');
declare variable $single-constituent-clause-rule := ('ADV2CL', 'Np2CL', 'Intj2CL', 'O22CL', 'O2CL', 'P2CL', 'PP2CL', 'Relp2CL', 'S2CL', 'V2CL');

declare function local:is-clause-rule($rule as node()) as xs:boolean
{
	if (not($rule = 'Np-Appos')
	and (
	contains($rule, '-')
	(:
	Ryder: single-constituent clauses often require nesting of subsequent siblings, so I now try to handle them individually rather than here.
	
	(\: There are also a number of single-constituent clauses. E.g., V2CL :\)
	or (contains($rule, '2CL')
	and not($rule = ('2CLaCL', '2CLaCLaCL', 'CLa2CL'))
	):)
	)
	) then
		true()
	else
		false()
};

declare function local:clause-is-projected($node as element(Node)) as xs:boolean
{
	(:	previous sibling should satisfy: //*contains(@LexDomain,"002004001009"):)
	(some $previous-node
	in $node/preceding-sibling::Node/descendant::m
		satisfies (
		$previous-node[contains(@LexDomain, "002004001009")])
		and not($node/parent::Node[@Cat = 'CL'])
	)
	(:
	TODO: disambiguate this lexical domain a bit further. Sometimes CRT (cut covenant) should not project (e.g., Gen 31.44)
	
	Ryder: do some of the projecting matrices follow the projection?
	If so, use the following block:
	
	or
	(some $following-sibling 
	in $node/following-sibling::Node/descendant::m 
	satisfies $following-sibling[contains(@LexDomain,"002004001009")])
	:)
};

declare function local:clause-is-projecting($node as element(Node)) as xs:boolean
{
	(:	self should satisfy: //*contains(@LexDomain,"002004001009"):)
	some $child
	in $node/descendant::m
		satisfies $child[contains(@LexDomain, "002004001009")]
};

(:~~~ function definitions ~~~:)

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

(: process attributes :)
declare function local:attributes($node)
{
	local:attributes($node, ())
};
declare function local:attributes($node, $exclusions)
(: FIXME: update attributes function based on macula hebrew changes since May 2022 :)
{
	if (local-name($node) = 'm')
	then
		(
		$node/@xml:id,
		$node/@mandarin,
		$node/@english,
		$node/@morph,
		$node/@pos,
		$node/@after,
		$node/@type,
		$node/@gloss,
		$node/@transliteration,
		$node/@SDBH ! attribute sdbh {.},
		$node/@lemma ! attribute stronglemma {.},
		$node/@LexDomain ! attribute lexdomain {.},
		$node/@ContextualDomain ! attribute contextualdomain {.},
		$node/@CoreDomain ! attribute coredomain {.},
		$node/ancestor::Node[1]/@SenseNumber ! attribute sensenumber {.},
		$node/ancestor::Node[1]/@Frame ! attribute frame {.},
		$node/ancestor::Node[1]/@Ref ! attribute participantref {.},
		$node/ancestor::Node[1]/@SubjRef ! attribute subjref {.},
		$node/ancestor::Node[1]/@Greek ! attribute greek {.},
		$node/ancestor::Node[1]/@GreekStrong ! attribute greekstrong {.},
		$node/ancestor::Node[1]/@StrongNumberX ! attribute strongnumberx {.},
		$node/ancestor::Node[1]/@Cat ! attribute class {.},
		$node/ancestor::Node[1]/@Unicode ! attribute unicode {.}
		)
	else
		if (not('class' = $exclusions)) then
			$node/@Cat ! attribute class {lower-case(.)}
		else
			(),
	$node/@Head ! attribute head {
		if (. = '0') then
			true()
		else
			false()
	},
	(:$node/@nodeId ! attribute xml:id {concat('o', lower-case(.))}, (\: NOTE: corpus-specific prefix 'o' is added to nodeIds here :\):)
	$node/@Rule ! attribute rule {lower-case(.)},
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
		()
};

(: process phrases :)

declare function local:phrase($node, $passed-role)
{
	<wg>{
			local:attributes($node),
			if ($passed-role) then
				attribute role {$passed-role}
			else
				(),
			$node/element() ! local:node(.)
		}</wg>
};

(: process clause - assign roles by clause rule :)

declare function local:clause($node, $passed-role)
{
	(:let $clauseIsProjected := local:clause-is-projected($node)
	let $clauseIsProjecting := local:clause-is-projecting($node):)
	
	if (contains($node/@Rule, '-')) then
		(: Ryder: multi-constituent clause :)
		let $clause-roles := tokenize(lower-case($node/@Rule), '-')
		return
			<wg>{
					local:attributes($node),
					if ($passed-role) then
						attribute role {$passed-role}
					else
						(),
					(:if ($clauseIsProjected) then
					attribute projected {'true'}:)
					(:else
					if ($clauseIsProjecting) then
						(
							<wg projecting="true">{
								for $clause-constituent at $index in $node/element()
									let $constituent-role := $clause-roles[$index]
									return
										if (local:clause-is-projecting($clause-constituent)) then local:node($clause-constituent, $constituent-role)
										else ()
							}</wg>,
							
							<wg projected="true">{
								for $clause-constituent at $index in $node/element()
									let $constituent-role := $clause-roles[$index]
									return
										if (local:clause-is-projecting($clause-constituent)) then ()
										else local:node($clause-constituent, $constituent-role)
							}</wg>
						)
				else:)
					for $clause-constituent at $index in $node/element()
					let $constituent-role := $clause-roles[$index]
					return
						local:node($clause-constituent, $constituent-role)
				}</wg>
	else
		local:process-single-constituent-clause($node, $passed-role)
};

declare function local:process-conjunctions($node, $passed-role)
{
	let $clauseIsProjected := local:clause-is-projected($node)
	let $clauseIsProjecting := local:clause-is-projecting($node)
	
	return
		<wg>{
				local:attributes($node),
				if ($passed-role) then
					attribute role {$passed-role}
				else
					(),
				if ($clauseIsProjected) then
					attribute projected {'true'}
					(: RYDER TODO: check if conjunction phrases are ever projecting/projected in output :)
				else
					if ($clauseIsProjecting) then
						attribute projecting {'true'}
					else
						(),
				for $constituent at $index in $node/element()
				return
					(: Ryder: if constituent is cjp, embed immediately following sibling :)
					if ($constituent/@Cat = ('cjp')) then
						<wg
							type='conjuncted-wg'>{
								
								local:attributes($constituent),
								$constituent ! local:node(.),
								$constituent/following-sibling::element()[1] ! local:node(.)
							}</wg>
					else
						(: Ryder: handle sibling following cjp :)
						if ($constituent/preceding-sibling::element()[1]/@Cat = ('cjp')) then
							()
						else
							$constituent ! local:node(.)
			}</wg>
};

(:declare function local:process-wrapper($node, $passed-role)
{
	(\: wrapper scope has a head, but the head is not the wrapper in the Nodes trees :\)
	(\: Ryder: I believe every @Head value is 0-indexed, whereas XPath positions are 1-indexed, so add 1 to @Head :\)
	let $headIndex := $node/@Head + 1
	let $headChild := $node/child::Node[$headIndex]
	let $childrenBeforeHead := $headChild/preceding-sibling::*
	let $childrenAfterHead := $headChild/following-sibling::*
	return
		<wg
			type="wrapper">{
				local:attributes($node),
				if ($passed-role) then
					attribute role {$passed-role}
				else
					(),
				
				$headChild/element() ! local:node(.),
				<wg
					type="scope">{
						$childrenBeforeHead ! local:node(.),
						$childrenAfterHead ! local:node(.)
					}</wg>
			}</wg>
};:)

declare function local:process-wrapper-clause($node, $passed-role)
{
	<wg
		type="wrapper-clause-scope">{
			local:attributes($node),
			if ($passed-role) then
				attribute role {$passed-role}
			else
				(),
			$node/element() ! local:node(.)
		}</wg>
};

(:declare function local:process-auxiliary($node, $passed-role)
{
	(\: 
		RYDER TODO: sort out when to nest auxiliaries using projected/projecting analysis 
		
		Rules already handled:
		* V2CL has been partly handled for standalone projecting verbs (e.g., Gen 31.11!7)
		
		Rules to check:
		* PP2CL
	:\)
	let $nodeIsProjected := local:clause-is-projected($node)
	let $nodeIsProjecting := local:clause-is-projecting($node)
	
	let $role := (
		if ($node/@Rule = 'V2CL' and $nodeIsProjecting) then
			'null'
		else if ($passed-role) then $passed-role
		else 'aux'
	)
	
	return
		(\: Ryder TODO: clean up this function after debugging complete :\)
		<wg debug='auxiliary function output'>{
				local:attributes($node),
				if (not($role = 'null')) then
					attribute role {$role}
				else
					(),
				if ($nodeIsProjected) then
					attribute projected {'true'}
				else
					if ($nodeIsProjecting) then
						attribute projecting {'true'}
					else
						(),
				$node/element() ! local:node(.)
			}</wg>
};:)

declare function local:disambiguate-complex-clause-structure($node, $passed-role)
{
	
	let $rules-that-have-been-disambiguated-in-this-function := ('ClCl', 'ClCl2', 'CLandCL2')
	return
		
		(: Ryder: Ensure an error is thrown for cases I have not yet handled. :)
		if (count($node/child::Node) > 2) then
			(: Try to process conjunctions and recount :)
			
			local:process-conjunctions($node, $passed-role)
			(:
			<error_unhandled_complex_clause_structure__too_many_children
				rule="{$node/@Rule}"/>:)
		else
			if (not($node/@Rule = $rules-that-have-been-disambiguated-in-this-function)) then
				(: Ryder: some other rules should probably be treated as complex clause structure requiring disambiguation (e.g., 'ClaCl'), and if they do, then they should trip this condition until their internal structure disambiguation is handled below :)
				<error_unknown_complex_clause_structure
					rule="{$node/@Rule}">{
						$node/element() ! local:node(.)
					}</error_unknown_complex_clause_structure>
			
			else
				
				let $first-constituent := $node/child::Node[1]
				let $second-constituent := $node/child::Node[2]
				
				(:
					Ryder: possible analyses for cases I have handled:
					- subordinate first constituent <-- assume case for ClCl
					- subordinate second constituent <-- assume case for ClCl2
					- coordinate constituents (group them) <-- I know this is sometimes the case in the Greek trees (e.g., Matt 12:3), but I'm not sure about the Hebrew trees
					- flatten some series of nested ClCl when they should be groups (e.g., potentially Isaiah 51.9, which has ClCl 4 or 5 deep)
					
					TODO:
					* handle complex clause structures beyond ClCl, ClCl2, and CLandCL2
					* handle projected speech
				:)
				
				let $should-coordinate-constituents := false()
				let $should-subordinate-first := ($node/@Rule = ('ClCl2', 'CLandCL2'))
				let $should-subordinate-second := ($node/@Rule = 'ClCl')
				return
				
					if ($should-coordinate-constituents) then (
						(: Ryder TODO: handle ClCl/ClCl2 that should be coordinated :)
					)
					else 
					
						let $constituent-to-raise := 
							if ($should-subordinate-first) then
								$second-constituent
							else
								$first-constituent
								
						let $constituent-to-subordinate := 
							if ($should-subordinate-first) then
								$first-constituent
							else
								$second-constituent
						
						(: Ryder TODO: disambiguate complex-cl constituent roles:
							* aux <-- minor clauses, interjections, etc.?
							* adv <-- absolutes, etc.
							* obj <-- e.g., direct discourse
						:)
						let $disambiguated-subordinate-role := ('d?')
						
						
						let $processed-head := local:node($constituent-to-raise, $passed-role)
						let $processed-subordinate := local:node($constituent-to-subordinate, $disambiguated-subordinate-role)
						
						return
							<wg>{
									(:local:attributes($node, 'class'),:)
									$node/@Rule,
									$node/@Cat,
									$node/@nodeId,
									local:attributes($processed-head),
									if ($passed-role) then
										attribute role {$passed-role}
									else
										(),
									$processed-head/element(),
									$processed-subordinate
								}</wg>
};

declare function local:process-group($node, $passed-role)
{
	(: Ryder: Complex node does not have a head; therefore coordinate its children as siblings
 TODO: disambiguate wrappers to determine whether some of these groups are in fact subordinating structures.
 TODO: disambiguate projection/projecting and figure out where nesting should occur of some children
:)
	let $clauseIsProjected := local:clause-is-projected($node)
	let $clauseIsProjecting := local:clause-is-projecting($node)
	
	return
		<wg type="group">{
				local:attributes($node, 'class'),
				if ($passed-role) then
					attribute role {$passed-role}
				else
					(),
				if ($clauseIsProjected) then
					attribute projected {'true'}
				else
					if ($clauseIsProjecting) then
						attribute projecting {'true'}
					else
						(),
				$node/child::element() ! local:node(.)
			}</wg>
};

declare function local:process-single-constituent-clause($node, $passed-role)
{
	(:
		Rules to handle here:
		* ADV2CL - Done; needs revisiting
		* Intj2CL - Done
		* Np2CL - Done; Ryder: these are mostly topics, though there are some tails (e.g., JOB 19:21); these are almost always in complex clause structures
		* O22CL - Done; needs revisiting
		* O2CL - Done; needs revisiting; usually the child of a relCL, but sometimes a complex clause structure
		* P2CL - Done
		* PP2CL - Done
		* Relp2CL - Done; needs revisiting: the ones I looked at all have some kind of additional wrapper which likely has an ADV role if anything.
		* S2CL - Ryder TODO: always the child of a complex clause structure. These need to be disambiguated carefully. Sometimes they are actually interpersonal moves such as affirmative responses (GEN 27:24!1). At other times they are simply eliptical/junctive constructions (both conjunctive, e.g., GEN 26:26!1, GEN 50:8!1, LEV 16:29!5, LEV 21:18!2, NUM 26:40!1, and also disjunctive, e.g., NUM 26:65!12). At other times they are appositional in poetry (e.g., GEN 49:7!5). At still other times they are simply verbless clauses in a ClCl (e.g., EXO 8:17!15), adverbial constituents of the headed clause in a CLa2CL (e.g., EXO 16:6!8), or items in a list (e.g., numerous instances in JOS 15:34), and likely others. It is probable that better disambiguation of complex clause structures will resolve many of these problems, and at the very least the disambiguation has to happen atthat stage of this query.
		* V2CL - Done
	:)
	let $internal-role := lower-case(substring-before($node/@Rule, '2CL'))
	return
	
	switch ($node/@Rule)
		case 'P2CL'
		case 'V2CL'
		case 'S2CL'
		case 'O2CL'
		case 'ADV2CL'
			return <wg>{
						attribute class {'cl'},
						local:attributes($node, 'class'),
						$node/element() ! local:node(., $internal-role)
					}</wg>
		
		case 'PP2CL'
			return 
				$node/element() ! local:node(., 'adv')	
		case 'Intj2CL'
		case 'Np2CL'
			return 
				$node/element() ! local:node(., 'aux')
		case 'O22CL'
			return 
				(: Ryder TODO: revisit and disambiguate these since they are tied to complex clause disambiguation. They may need to have the $passed-role in cases where a ClCl parent has a projecting verb and content (and this O22CL could be the content, for example. :)
				$node/element() ! local:node(., ())
		case 'Relp2CL'
			return 
				$node/element() ! local:node(., $passed-role)
		
		default
			return
				<error_unhandled_single_constituent_clause role="err" rule="{$node/@Rule}">{$node/element() ! local:node(.)}</error_unhandled_single_constituent_clause>
				
				
				
	(:
	
	TODO: *** use this comment to update this function to handle projecting V2CL
	Ryder: here is how I handled single-constituent-clauses in the local:clause() function:
	
	
	(: 
			Ryder: TODO: clean up single-constituent clause
			
			Rules handled:
			* General auxiliary rules
			* V2CL - when projecting it should nest next sibling as object
			* TODO: check relCL in o010310010111 - prep phrase as predicate? I don't think this should be a clause, but rather a phrase
		:)
		let $clause-role := substring-before($node/@Rule, '2')
		
		let $clause-is-auxiliary := (
		$node/@Rule = $auxiliary-rule
		and not($node/parent::Node[@Cat = 'pp'])
		and not(local:clause-is-projecting($node))
		)
		
		let $clause-is-projecting-verb := (
			$node/@Rule = 'V2CL'
			and local:clause-is-projecting($node)
		)
		
		return
			if ($clause-is-auxiliary) then
				local:node($node/element(), 'aux2')
			else if ($clause-is-projecting-verb) then
				(: 
				*******
				*******
				*******
				
				Ryder TODO: this should happen at the higher level... complex clauses that contain single-constituent clauses? :)
				let $projecting-node := local:node($node/element(), 'v.proj')
				let $projected-node := local:node(
					$node/following::Node[descendant::m][1],
					'o.proj'
				)
				
				return <wg type="projection-scope" class="cl">{
					$projecting-node,
					$projected-node
				}</wg>
				
			else
				
				<error_unhandled_single_constituent_clause>{
						$node/@*,
						$node/element() ! local:node(.)
					}
				</error_unhandled_single_constituent_clause>
	
	:)
};

declare function local:process-complex-node($node, $passed-role)
{
	(:  
    Nodes that make it here 
    - (1) have @Rule, 
    - (2) are not atomic nodes, and
    - (3) have had their coordination processed already, so as to attach every conjunction with its scope
    
    Some of these nodes are groups.
    - Group
    Some of them need to subordinate the head node (e.g., preposition phrases)
    - TODO: Are there some rules where there is one wrapper but multiple wrapped nodes?
    Others need to subordinate only the non-heads (the modifiers).
    
    check for $headed-structure-rule or $group-rule or $wrapper-clause-rule :)
	
	(: WRAPPERS - subordinates siblings :)
	if ($node/@Rule = $wrapper-rule) then
		(:local:process-wrapper($node, $passed-role):)
		<wg
			type="wrapper-scope">{
				local:attributes($node),
				if ($passed-role) then
					attribute role {$passed-role}
				else
					(),
				$node/element() ! local:node(.)
			}</wg>
	else
		(: GROUP STRUCTURE - coordinate siblings :)
		if ($node/@Rule = ($group-rule, $apposition-rule)) then
			local:process-group($node, $passed-role)
		
		else
			
			(: COMPLEX CLAUSE RULE - create child from non-head sibling
            TODO: disambiguate role in new parent clause (some siblings
            will be auxiliaries, many will be adverbial, any other options? )
            
            :)
			if ($node/@Rule = ($modifier-structure-rule, $hebrew-determiner-rule, $aramaic-determiner-rule)) then
				(: Ryder: keep modifier with modified. Note that aramaic determiners follow their nominal :)
				<wg>{
						attribute type {'modifier-scope'},
						local:attributes($node, 'class'),
						if ($passed-role) then
							attribute role {$passed-role}
						else
							(),
						$node/element() ! local:node(.)
					}</wg>
			else
				if ($node/@Rule = $wrapper-clause-rule) then
					local:process-wrapper-clause($node, $passed-role)
				else
					if ($node/@Rule = $aramaic-structure-rule) then
						(: Ryder: these obviously only occur a handful of times in Daniel, Jeremiah, and Ezra. :)
						<wg
							type="aramaic-structure">{
								local:attributes($node),
								$node/element() ! local:node(.)
							}</wg>
					else
						if ($node/@Rule = $complex-clause-rule) then
							local:disambiguate-complex-clause-structure($node, $passed-role)
						else
							(: Ryder: V2CL is a clause with only a 'verb' constituent :)
							if ($node/@Rule = $single-constituent-clause-rule) then
								local:process-single-constituent-clause($node, ())
						
						else
							<error_unknown_complex_node
								rule="{$node/@Rule}">{$node/element() ! local:node(.)}</error_unknown_complex_node>
};

declare function local:process-word($node, $passed-role)
{
	if ($node/m) then
		$node/m ! <w>{
				local:attributes(.),
				if ($passed-role) then
					attribute role {$passed-role}
				else
					(),
				./text()
			}</w>
	else
		if ($node/c) then
			(: Ryder: TODO: handle compound morphemes :)
			$node/c/m ! <w
				compound="true">{
					local:attributes(.),
					if ($passed-role) then
						attribute role {$passed-role}
					else
						(),
					./text()
				}</w>
		else
			$node/element() ! local:node(., $passed-role)
};

declare function local:node-type($node as element())
{
	if (not($node/@Rule)) then
		'non-rule-node'
	else
		if ($node/@Cat = 'S' and $node/Node[@Cat = 'cjp']) then
			(: Ryder: The top level sentence may have clauses and conjunctions. 
            See local:sentence() below. In theory, these could be treated as discourse-progression markers,
            but for now they are being treated as simple conjunctions. 
            
            TODO: 
            * disambiguate these based on conjunction type. E.g., ISA 2:22 has a second child of the sentence that should be a clause constituent.
            :)
			'conjunctions-to-be-processed'
		(:
		else if (some $child in $node/element() satisfies local:clause-is-projecting($child) then
			(\: Ryder: once we have @depth data on the nodes, process it here, before anything else. 
			
			Notes: 
			* downstream functions will need refactoring (such as auxiliary processing)
			* projected content should cover the following content until depth returns to the same level as the projecting element
			* however, we will probably only extend it to the end of the sentence at most for the treedown display.
			:\)
			'projections-to-be-processed'
		:)
		
		else
			if ($node/@Rule = $conjuncted-structure-rule) then
				'conjunctions-to-be-processed'
			else
				if (local:is-clause-rule($node/@Rule)) then
					'clause'
				else
					if ($node/@Rule = $atomic-structure-rule) then
						'atomic'
					else
						'complex' (: Ryder: note - if something had an erroneous rule it would end up being a 'complex' unit :)
};

(: Ryder: declare both 1-arg and 2-arg node-processing functions so the function can be called with or without the second argument. :)
declare function local:node($node as element()) {
	local:node($node, ())
};
declare function local:node($node as element(), $passed-role as xs:string?)
{
	(: Ryder: This function should only ever process exactly one element. If multiple are being passed, use the simple mapping operator (e.g., instead of local:node($node), use $node/element() ! local:node(.) :)
	if (count($node) gt 1) then
		<error_too_many_nodes>{$node}</error_too_many_nodes>
	else
		if ($node/@Cat = 'S' and $node[parent::Tree]) then
			(: Ryder: in the Hebrew trees, top-level clauses may have conjunction AND clause siblings. These need to be processed to properly attach the conjunctions to their conjuncted siblings. :)
			local:process-conjunctions($node, $passed-role)
		else
			switch (local:node-type($node))
				case "non-rule-node"
					return
						local:process-word($node, $passed-role)
				case "conjunctions-to-be-processed"
					return
						local:process-conjunctions($node, $passed-role)
				case "clause"
					return
						local:clause($node, $passed-role)
				case "atomic"
					return
						$node/element() ! local:node(., $passed-role)
				case "complex"
					return
						local:process-complex-node($node, $passed-role)
				default
				return
					<error_unknown_node_type>{$node/@*}</error_unknown_node_type>
};

(: sentence :)

declare function local:straight-text($node)
{
	for $n at $i in $node//Node[m]
	let $afterValue := string($n/m/@*[name() = 'after']) (: Ryder: convoluted attribute name here allows me to format and indent the file in oxygen... :)
	let $textValue := string($n/m/text())
		order by $n/@morphId
	return
		($textValue,
		if (string-length($afterValue) > 0) then
			$afterValue
		else
			'NOAFTERVALUE')
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
				{replace(string-join(local:straight-text($node)), 'NOAFTERVALUE', '')}
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
	id="{(/descendant::Sentence)[1]/substring(@verse, 1, 5)}">
	{
		(:
            If a sentence has multiple interpretations, Sentence/Trees may contain
            multiple Tree nodes.  We want to specify which interpretation to prefer.
        :)
		let $interpretationToPrefer := 1
		
		(: Process sentences in recently-built dependency tree :)
		for $sentence in //Tree[$interpretationToPrefer]/Node
		return
			local:sentence($sentence)
	}
</chapter>