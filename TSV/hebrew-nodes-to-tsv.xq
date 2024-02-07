(: NOTE: Adapted from TSV/hebrew-lowfat-to-tsv.xq and mappings/lowfat-macula-hebrew.xquery :)
declare function local:val($v)
{
   ($v,"")[1]
};

declare function local:row($w)
{
  for $name in local:headers()
  return
    if ($name = "text") then local:val($w/text()) ! string(.)
    else local:val($w/@*[name(.) = $name])
};

declare function local:headers()
{
    "xml:id",
    "ref",
    "class",
    "text",
    "transliteration",
    "after",
    "strongnumberx",
    "stronglemma",
    "sensenumber",
    "greek",
    "greekstrong",
    "gloss",
    "english",
    "mandarin",
    "stem",
    "morph",
    "lang",
    "lemma",
    "pos",
    "person",
    "gender",
    "number",
    "state",
    "type",
    "lexdomain",
    "contextualdomain",
    "coredomain",
    "sdbh",
    "extends",
    "frame",
    "subjref",
    "participantref"
};

(: declare function local:headers()
{
    "xml:id",
    "text"
}; :)

declare variable $group-rule := ('12Np', '2Advp_h1', '2Advp_h2', '2CLaCL', '2CLaCLaCL', '2Np', '2NpaNpaNp', '2Pp', '2Pp', '2PpaPp', '3Adjp', '3NpaNp', '4NpaNp', '7Np', 'ADJPaADJPADJPaADJP', 'ADVaADV', 'ADVaADVaADVaADV', 'AdjpAdjp', 'AdjpAdjpandAdjp', 'AdjpaAdjp', 'AdjpandAdjpAdjp', 'AdvpaAdvp', 'AdvpandAdvp', 'CLa2CL', 'CLaCL', 'CjpAdvpCjpAdvp', 'CjpCjp', (:'ClCl', 'ClCl2', :) 'ClClCl', 'ClClClCl', 'ClClClClCl', 'ClClClClClCl', 'ClClaClaClaClaCl', 'ClaClClaCl', 'ClaClaClCl', 'Conj11Np', 'Conj2Pp', 'Conj3Adjp', 'Conj3CL', 'Conj3Np', 'Conj3Pp', 'Conj4Adjp', 'Conj4CL', 'Conj4Np', 'Conj4Pp', 'Conj5CL', 'Conj5Np', 'Conj5Pp', 'Conj6Np', 'Conj6Pp', 'Conj7Np', 'Conj7Pp', 'Conj8Np', 'Conj9Np', 'IjpIjp', 'NP10NP', 'NP3NP', 'NPNPNPNPaNPNPNPNPNPaNPNPNPNPNP', 'NPNPNPNPaNPaNPaNP', 'NPNPNPaNPNPaNP', 'NPNPNPaNPaNP', 'NPNPNPaNPaNPaNP', 'NPNPaNPNPNPNPNPaNP', 'NPNPaNPNPNPaNP', 'NPNPaNPNPaNP', 'NPNPaNPNPaNPaNP', 'NPNPaNPaNPaNP', 'NPNPaNPaNPaNPaNP', 'NPNPaNPaNPaNPaNPaNP', 'NPaNPNP', 'NPaNPNPNP', 'NPaNPNPNPNP', 'NPaNPNPNPNPNP', 'NPaNPNPNPNPNPNP', 'NPaNPNPNPNPNPaNPNP', 'NPaNPNPNPNPNPaNPaNP', 'NPaNPNPNPNPaNP', 'NPaNPNPNPaNP', 'NPaNPNPaNP', 'NPaNPNPaNPNP', 'NPaNPNPaNPNPaNP', 'NPaNPNPaNPNPaNPaNP', 'NPaNPaNPNP', 'NPaNPaNPNPNPNPNPNPNPNPNPNPNP', 'NPaNPaNPNPNPaNP', 'NPaNPaNPNPaNP', 'NPaNPaNPNPaNPNPNPaNPaNP', 'NPaNPaNPNPaNPNPaNP', 'NPaNPaNPNPaNPaNP', 'NPaNPaNPaNPNP', 'NPaNPaNPaNPNPaNP', 'NPaNPaNPaNPaNPNPNP', 'NPaNPaNPaNPaNPNPaNP', 'NPnp4NP', 'NPnp5NP', 'Np5Np', 'NpNp5', 'NpNp6', 'NpNpNp', 'NpNpNp11', 'NpNpNpNp', 'NpNpNpNpNp', 'NpNpNpNpNpNp', 'NpNpNpNpNpNpNpaNp', 'NpNpNpNpNpNpaNp', 'NpNpNpNpNpaNp', 'NpNpNpNpNpaNpNp', 'NpNpNpNpNpaNpaNp', 'NpNpNpNpaNpNpaNp', 'NpNpaNpNp', 'NpaNp', 'PP8PP', 'PP9PP', 'PPPP4', 'PPPP5', 'PPandPP', 'PpPp', 'PpPp9', 'PpPpPp', 'PpPpPpPp', 'PpPpPpPpPp', 'PpPpPpPpandPp', 'PpPpPpaPpaPpaPpaPp', 'PpPpPpandPp', 'PpPpPpandPpPp', 'PpPpaPpaPpaPp', 'PpPpandPpPp', 'PpaPpPpPpPpaPp', 'PpaPpPpaPp', 'PpandPpPp', 'Relp3Relp', 'Relp5Relp', 'RelpandRelp', 'VP3VP', 'VPandVP', 'aNpaNp', 'aNpaNpaNp', 'aPpaPp', 'aPpaPpaPp', 'ppPP5PP', 'ppPP6PP', 'ppappPP5PP', 'RelpRelp', 'aCLaCL', 'aCLaCLaCL', 'NumpAndNump', 'NumpNump', 'NumpNumpNumpNump', 'NumpNumpNumpaNump', 'NumpNumpaNump', 'NumpNumpaNumpaNump', 'NumpaNumpNump', 'NumpaNumpNumpaNump', 'NumpaNumpaNump', 'NumpaNumpaNumpaNump');
declare variable $aramaic-determiner-rule := ('NPDet', 'NumpDet', 'AdjpDet');
declare variable $nominalized-clause-rule := ('CL2Adjp', 'CL2NP');

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
		$node/@word ! attribute ref {.},
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
			if ($node/@Cat = $group-rule) then ()
			else
				$node/@Cat ! attribute class {lower-case(.)}
		else
			(),
	(:
	Ryder: I believe @Head is actually a 0-index value declaring which child is the head
	$node/@Head ! attribute head {
		if (. = '0') then
			true()
		else
			false()
	},:)
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

string-join(local:headers(), "	")
,
for $m in //m
order by $m/@xml:id
let $w := <w>{
    local:attributes($m),
    $m/text()
}</w>
return string-join((local:row($w)), "	")
