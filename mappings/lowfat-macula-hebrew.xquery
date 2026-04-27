(:~~~ Rule taxonomy ~~~

  Input `Node` elements carry a @Rule attribute encoding internal structure.
  This transform dispatches primarily on @Cat values, not @Rule.
  Only the two variables below are actively consulted during processing.
  The full rule taxonomy (atomic, conjuncted, group, modifier, complex-clause,
  wrapper, apposition, auxiliary, single-constituent rules) is documented in
  the project wiki and available in git history for reference.

  Rule name conventions in the input trees:
    - "X2Y"    — a single constituent of type X filling role Y (e.g. N2NP, V2VP)
    - "XY"     — a modifier structure: X modifies head Y (e.g. PrepNp, DetNP)
    - "XaY"    — X and Y conjoined with "and"/וְ (e.g. CLaCL, NpaNp)
    - "ConjNX" — conjunction followed by N constituents of type X (e.g. Conj3Np)
    - "ClCl"   — two clauses in a complex; ClCl = first is head, ClCl2 = second is head

:)

(: Aramaic determiner rules: in Aramaic (Daniel, Ezra-Nehemiah), the
   determinateness marker FOLLOWS the noun (post-positive). These nodes
   receive @articular='true' in the output. Contrast with Hebrew, where the
   definite article precedes its noun (morph="Td") and is handled at the
   morpheme level, not the rule level. :)
declare variable $aramaic-determiner-rule := ('NPDet', 'NumpDet', 'AdjpDet');

(: Nominalized clause rules: a clause functioning as a noun phrase — embedded
   as a subject, object, or complement of an enclosing predicate. These nodes
   receive @clausetype='nominalized-clause' in the output. :)
declare variable $nominalized-clause-rule := ('CL2Adjp', 'CL2NP');


(:~~~ Reference functions ~~~:)

(: Maps the 2-digit book prefix of a node ID (e.g. "01") to its USFM book code
   (e.g. "GEN"). Node ID format: BBCCCVVVMM where BB=book, CCC=chapter,
   VVV=verse, MM=word position within verse. :)
declare function local:USFMBook($nodeId)
{
	if (string-length($nodeId) < 1)
	then
		"error5"
	else
		switch (xs:integer(substring($nodeId, 1, 2)))
			case 01 return "GEN"
			case 02 return "EXO"
			case 03 return "LEV"
			case 04 return "NUM"
			case 05 return "DEU"
			case 06 return "JOS"
			case 07 return "JDG"
			case 08 return "RUT"
			case 09 return "1SA"
			case 10 return "2SA"
			case 11 return "1KI"
			case 12 return "2KI"
			case 13 return "1CH"
			case 14 return "2CH"
			case 15 return "EZR"
			case 16 return "NEH"
			case 17 return "EST"
			case 18 return "JOB"
			case 19 return "PSA"
			case 20 return "PRO"
			case 21 return "ECC"
			case 22 return "SNG"
			case 23 return "ISA"
			case 24 return "JER"
			case 25 return "LAM"
			case 26 return "EZK"
			case 27 return "DAN"
			case 28 return "HOS"
			case 29 return "JOL"
			case 30 return "AMO"
			case 31 return "OBA"
			case 32 return "JON"
			case 33 return "MIC"
			case 34 return "NAM"
			case 35 return "HAB"
			case 36 return "ZEP"
			case 37 return "HAG"
			case 38 return "ZEC"
			case 39 return "MAL"
			default return "###"
};

(: Constructs a USFM verse reference ("GEN 1:1") from a node ID. :)
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


(:~~~ Attribute mapping ~~~:)

(: Flattens the attributes of an <m> (morpheme) element into a sequence of
   attributes for a lowfat <w> element.

   Source attributes come from two levels:
     - The <m> element itself: xml:id, morph, lang, lemma, pos, after, gender,
       number, state, stem, person, type, and gloss/domain fields.
     - The parent <Node>: StrongNumberX, SenseNumber, Frame, Ref, SubjRef,
       Greek, GreekStrong (annotation attributes on the containing tree node).
     - The nearest ancestor <Node>: Unicode (pointed text form).

   Attribute name remappings to lowfat conventions:
     @word             → @ref
     @SDBH             → @sdbh
     @lemma            → @stronglemma  (lexical lemma)
     @LexDomain        → @lexdomain
     @ContextualDomain → @contextualdomain
     @CoreDomain       → @coredomain
     @SenseNumber      → @sensenumber
     @Frame            → @frame
     @Ref              → @participantref
     @SubjRef          → @subjref
     @Greek            → @greek
     @GreekStrong      → @greekstrong
     @StrongNumberX    → @strongnumberx
     @Unicode (anc.)   → @unicode

   @class: lower-case of the morpheme's own @Cat when present; otherwise
   lower-case of the nearest ancestor Node's @Cat (for subsumed elements
   such as definite articles absorbed into the following word).

   @lemma is also emitted directly as the morphological lemma, distinct from
   @stronglemma which is the lexical/dictionary lemma.

   @head marks this morpheme's containing Node as the syntactic head of its
   parent phrase or clause. :)
declare function local:attributes($node)
{
    (: from the <m> element :)
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
	(: from the parent <Node> :)
	$node/parent::Node/@SenseNumber ! attribute sensenumber {.},
	$node/parent::Node/@Frame ! attribute frame {.},
	$node/parent::Node/@Ref ! attribute participantref {.},
	$node/parent::Node/@SubjRef ! attribute subjref {.},
	$node/parent::Node/@Greek ! attribute greek {.},
	$node/parent::Node/@GreekStrong ! attribute greekstrong {.},
	$node/parent::Node/@StrongNumberX ! attribute strongnumberx {.},
	(: Unicode pointed text from nearest ancestor Node :)
	$node/ancestor::Node[1]/@Unicode ! attribute unicode {.},
	(: @class from morpheme's own @Cat, or ancestor's @Cat for subsumed elements :)
	if ($node/@Cat) then
		attribute class {lower-case($node/@Cat)}
	else
		attribute class {lower-case($node/ancestor::Node[1]/@Cat)},
	(: rule taxonomy flags (the two rule variables consulted in this transform) :)
	if ($node/@Rule = $aramaic-determiner-rule) then
		attribute articular {'true'}
	else
		(),
	if ($node/@Rule = $nominalized-clause-rule) then
		attribute clausetype {'nominalized-clause'}
	else
		(),
	(: remaining morphological attributes :)
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
	(: @head: marks this element as the head of its parent phrase/clause.
	   @Head is 0-based in the source; we shift to 1-based for XPath. :)
	let $head := $node/parent::Node/@Head + 1
	let $headNode := $node/parent::Node/*[$head]
	where $node is $headNode
	return attribute head { true() }
};


(:~~~ Clause utilities ~~~:)

(: Returns true when a clause node (Cat="CL") should be preserved as a <wg>
   in the output rather than dissolved.

   A clause is preserved when:
     - Its parent node has type 'role' — the clause fills a named syntactic slot.
     - OR its @Rule is 'sub-CL' — an explicitly marked subordinate clause.
     - OR its @Rule is anything other than 'ClCl'/'ClCl2'.

   Bare ClCl/ClCl2 nodes whose parent is not a role node are dissolved: their
   children are promoted to the parent level to avoid spurious nesting of
   peer clauses. :)
declare function local:is-worth-preserving($clause)
{
    local:node-type($clause/parent::*) = 'role'
    or $clause/@Rule='sub-CL'
    or not($clause/@Rule=('ClCl','ClCl2'))
};

(: Traverses down a chain of single-child Nodes. Returns the terminal leaf
   Node if the entire subtree collapses to exactly one morpheme; otherwise
   returns the empty sequence.

   Used by local:phrase and local:role to flatten trivial single-word
   constituents directly to <w> without a wrapping <wg>. :)
declare function local:oneword($node)
{
     if (count($node/Node) > 1)
     then ()
     else if ($node/Node)
     then local:oneword($node/Node)
     else $node
};


(:~~~ Output functions ~~~

   Four functions produce the lowfat XML. Each handles one layer of the
   source tree, dispatched by local:node() via local:node-type():

     local:clause  — Cat="CL" (full clauses)
     local:phrase  — lowercase Cat values (np, pp, vp, adjp, advp, relp, ...)
     local:role    — uppercase Cat values (S, IO, ADV, O, O2, P, PP, V, VC)
     local:word    — leaf nodes: <m> morphemes and <c> compound-word groups

:)

(: Processes a clause node (Cat="CL").
   - If worth preserving: <wg class="cl" rule="..." head="...">children</wg>
   - Otherwise: dissolve and emit children directly. :)
declare function local:clause($node)
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

(: Processes a phrase-level node (lowercase Cat: np, pp, vp, adjp, advp, etc.).
   - Single-word subtree: promote the word directly as <w> (no wrapping <wg>).
   - Multi-word subtree: <wg class="np" rule="..." head="...">children</wg>. :)
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

(: Processes a role node (uppercase Cat: S, IO, ADV, O, O2, P, PP, V, VC).

   @role is the lowercase Cat value (S→s, IO→io, ADV→adv, O→o, O2→o2,
   P→p, PP→pp, V→v, VC→vc). Exception: the sentence-root node (parent is
   Tree) receives no @role — it has no role relative to an enclosing clause.

   Three output cases:
   1. Single-word subtree → <w role="..."> directly.
   2. Multiple child Nodes → <wg role="...">children</wg>.
      Note: no @class is emitted here; see internal issue #17.
   3. Exactly one child Node → <wg role="..." (attrs from child phrase)>
      grandchildren</wg>. Merges the role node with its single child
      phrase to avoid double-wrapping. :)
declare function local:role($node)
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

(: Processes a leaf node, producing a <w> (or <c> for compound words).

   $node may be a word-level Node (containing <m> or <c>) or an <m> directly.

   Compound words (<c> elements): Hebrew sometimes groups morphemes into a
   compound spanning an orthographic word boundary (e.g. proper nouns like
   תּוּבַל קַיִן). These produce:
     <c role="..."><w>...part 1...</w><w>...part 2...</w></c>
   See internal issue #18 for tracking whether compounds need further work.

   Normal output: <w role="..." xml:id="..." morph="..." ...>text</w> :)
declare function local:word($node)
{
    local:word($node, ())
};

declare function local:word($node, $role)
{
    if ($node/c) then <c>{$role, $node/c/m ! local:word(.)}</c>
    else if ($node/m)
    then local:word($node/m, $role)
    else if ($node/*) then ( element error {$role, $node })
    else
        <w>
            {
                $role,
                local:attributes($node),
                string($node)
            }
        </w>
};

(: Determines the processing category for a Node element.

   "word"   — node contains <m> children directly (terminal morpheme leaf)
   "phrase" — lowercase @Cat values:
                adj adv art conj cj cjp det ij ijp intj noun num np nump
                om omp pp prep pron ptcl rel relp verb vp adjp advp x
              (om=object marker, omp=object marker phrase,
               cj/cjp=conjunction/phrase, rel/relp=relative marker/phrase,
               ij/ijp=interjection/phrase, x=miscellaneous)
   "role"   — uppercase @Cat: S IO ADV O O2 P PP V VC
   "clause" — @Cat="CL"
   "####"   — unrecognised @Cat; should never occur in well-formed data :)
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
        case "omp"
        case "om"
        case "cjp"
        case "cj"
        case "relp"
        case "rel"
        case "ijp"
        case "ij"
        case "x"
            return "phrase"
        case "S"
        case "IO"
        case "ADV"
        case "O"
        case "O2"
        case "P"
        case "PP"
        case "V"
        case "VC"
            return "role"
        case "CL"
            return "clause"
        default
        return "####"
};

(: Main dispatch: routes each Node to the appropriate output function. :)
declare function local:node($node as element(Node))
{
    switch (local:node-type($node))
        case "word"    return local:word($node)
        case "phrase"  return local:phrase($node)
        case "role"    return local:role($node)
        case "clause"  return local:clause($node)
        default        return $node
};


(:~~~ Text and sentence utilities ~~~:)

(: Concatenates the plain text of all morphemes in $node's subtree, ordered
   by xml:id (which encodes book/chapter/verse/word position). Each morpheme's
   text is followed by its @after separator (space, maqaf, sof-pasuq, etc.).
   Produces the readable text for the <p> element in each <sentence>. :)
declare function local:straight-text($node)
{
    let $strings :=
        for $m in $node//m
        order by $m/@xml:id
        return concat($m/text(), $m/@after)
    return
        string-join($strings,"")
};

(: Wraps a top-level Tree Node as a <sentence> element.

   Output:
     <sentence id="GEN 1:2">
       <p><milestone unit="verse" id="GEN 1:2">GEN 1:2</milestone> text...</p>
       (syntax tree from local:node)
     </sentence>

   The <p> contains one <milestone> per distinct verse spanned (most sentences
   are single-verse; a few span verse boundaries). :)
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
						<milestone unit="verse">
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


(:~~~ Execution ~~~:)

(:  If a sentence has multiple interpretations, Sentence/Trees may contain
    multiple Tree nodes. The first is the preferred interpretation. :)

processing-instruction xml-stylesheet {'href="hebrew-treedown.css"'},
processing-instruction xml-stylesheet {'href="hebrew-boxwood.css"'},
<chapter
	lang="he"
	id="{(/descendant::Sentence)[1]/substring(@verse, 1, 5)}">
	{
		for $sentence in //Tree[1]/Node
		return
			local:sentence($sentence)
	}
</chapter>
