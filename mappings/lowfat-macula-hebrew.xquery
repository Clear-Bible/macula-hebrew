(:~~~ rule types ~~~:)

(: Ryder: atomic structure rules are simple promotion/conversion rules :)
declare variable $atomic-structure-rule := ('ADV2CL', 'Adj2Adjp', 'Adj2Advp', 'Adj2NP', 'Adj2Rel', 'AdjP2NP', 'Adjp2O', 'Adjp2P', 'Adjp2V', 'Adv2Adjp', 'Adv2Advp', 'Adv2Cjp', 'Adv2Pp', 'Adv2Ptcl', 'Advp2ADV', 'Advp2P', 'CL2ADV', 'CL2Adjp', 'CL2NP', 'CL2O2x', 'CL2Ox', 'CL2P', 'CL2PP', 'CL2S', 'Cj2Cjp', 'Cjp2ADV', 'Cjp2P', 'Ij2Ijp', 'Ijp2ADV', 'Ijp2advp', 'Intj2CL', 'N2NP', 'N2NP', 'NP2PP', 'Np2ADV', 'Np2CL', 'Np2O', 'Np2O2', 'Np2P', 'Np2Pp', 'Np2S', 'Num2Nump', 'Nump2ADV', 'Nump2NP', 'O22CL', 'O2CL', 'ObjMarker', 'P2Advp', 'P2CL', 'P2PP', 'PP2CL', 'Pp2Cjp', 'Pp2Np', 'Pp2P', 'Pp2PP', 'Pp2S', 'Pron2Adjp', 'Pron2NP', 'Ptcl2ADV', 'Ptcl2Np', 'Relp2CL', 'Relp2Np', 'S2CL', 'V2ADJP', 'V2AdvP', 'V2CL', 'V2VP', 'VerbX', 'Vp2Np', 'Vp2V', 'adjp2ADV', 'adjp2O2', 'advp2np', 'cjp2np', 'cjp2pp', 'ijp2P', 'ijp2V', 'ijp2np', 'np2adjp', 'np2advp', 'np2cjp', 'np2ijp', 'np2vp', 'pp2ptcl', 'ptcl2P', 'rel2vp', 'vp2ADV');
(: Ryder: conjuncted structure rules are non-atomic rules that include conjunctions/conjunction phrases :)
declare variable $conjuncted-structure-rule := ('2CLaCL', '2CLaCLaCL', '2NpaNpaNp', '2PpaPp', '3NpaNp', '4NpaNp', 'ADJPaADJPADJPaADJP', 'ADVaADV', 'ADVaADVaADVaADV', 'AdjpAdjpandAdjp', 'AdjpaAdjp', 'AdjpandAdjpAdjp', 'AdvpaAdvp', 'AdvpandAdvp', 'AdvpandPp', 'CLa2CL', 'CLaCL', 'CLandCL2', 'CjpAdjp', 'CjpAdvp2Advp', 'CjpAdvpCjpAdvp', 'CjpCjp', 'ClClaClaClaClaCl', 'ClaClClaCl', 'ClaClaClCl', 'Conj11Np', 'Conj2Pp', 'Conj3Adjp', 'Conj3CL', 'Conj3Np', 'Conj3Pp', 'Conj4Adjp', 'Conj4CL', 'Conj4Np', 'Conj4Pp', 'Conj5CL', 'Conj5Np', 'Conj5Pp', 'Conj6Np', 'Conj6Pp', 'Conj7Np', 'Conj7Pp', 'Conj8Np', 'Conj9Np', 'NP10NP', 'NP3NP', 'NPNPNPNPaNPNPNPNPNPaNPNPNPNPNP', 'NPNPNPNPaNPaNPaNP', 'NPNPNPaNPNPaNP', 'NPNPNPaNPaNP', 'NPNPNPaNPaNPaNP', 'NPNPaNPNPNPNPNPaNP', 'NPNPaNPNPNPaNP', 'NPNPaNPNPaNP', 'NPNPaNPNPaNPaNP', 'NPNPaNPaNPaNP', 'NPNPaNPaNPaNPaNP', 'NPNPaNPaNPaNPaNPaNP', 'NPaNPNP', 'NPaNPNPNP', 'NPaNPNPNPNP', 'NPaNPNPNPNPNP', 'NPaNPNPNPNPNPNP', 'NPaNPNPNPNPNPaNPNP', 'NPaNPNPNPNPNPaNPaNP', 'NPaNPNPNPNPaNP', 'NPaNPNPNPaNP', 'NPaNPNPaNP', 'NPaNPNPaNPNP', 'NPaNPNPaNPNPaNP', 'NPaNPNPaNPNPaNPaNP', 'NPaNPaNPNP', 'NPaNPaNPNPNPNPNPNPNPNPNPNPNP', 'NPaNPaNPNPNPaNP', 'NPaNPaNPNPaNP', 'NPaNPaNPNPaNPNPNPaNPaNP', 'NPaNPaNPNPaNPNPaNP', 'NPaNPaNPNPaNPaNP', 'NPaNPaNPaNPNP', 'NPaNPaNPaNPNPaNP', 'NPaNPaNPaNPaNPNPNP', 'NPaNPaNPaNPaNPNPaNP', 'NPandPP2np', 'NPnp4NP', 'NPnp5NP', 'NpNp5', 'NpNp6', 'NpNpNpNpNpNpNpaNp', 'NpNpNpNpNpNpaNp', 'NpNpNpNpNpaNp', 'NpNpNpNpNpaNpNp', 'NpNpNpNpNpaNpaNp', 'NpNpNpNpaNpNpaNp', 'NpNpaNpNp', 'NpaNp', 'NumpAndNump', 'NumpNumpNumpaNump', 'NumpNumpaNump', 'NumpNumpaNumpaNump', 'NumpaNumpNump', 'NumpaNumpNumpaNump', 'NumpaNumpaNump', 'NumpaNumpaNumpaNump', 'PP8PP', 'PP9PP', 'PPPP4', 'PPPP5', 'PPandPP', 'PpPp9', 'PpPpPpPpandPp', 'PpPpPpaPpaPpaPpaPp', 'PpPpPpandPp', 'PpPpPpandPpPp', 'PpPpaPpaPpaPp', 'PpPpandPpPp', 'PpaPpPpPpPpaPp', 'PpaPpPpaPp', 'PpandAdvp', 'PpandPpPp', 'Relp3Relp', 'Relp5Relp', 'RelpandRelp', 'VP3VP', 'VPandVP', 'aCLaCL', 'aCLaCLaCL', 'aNpaNp', 'aNpaNpaNp', 'aPpaPp', 'aPpaPpaPp', 'cjpCLx', 'cjpNp', 'cjpPp', 'ppPP5PP', 'ppPP6PP', 'ppappPP5PP');
(: Ryder: groups repeat the same structure multiple times. This test could probably be nuanced a bit more (e.g., should any of these have heads?) :)
declare variable $group-rule := ('12Np', '2Advp_h1', '2Advp_h2', '2CLaCL', '2CLaCLaCL', '2Np', '2NpaNpaNp', '2Pp', '2Pp', '2PpaPp', '3Adjp', '3NpaNp', '4NpaNp', '7Np', 'ADJPaADJPADJPaADJP', 'ADVaADV', 'ADVaADVaADVaADV', 'AdjpAdjp', 'AdjpAdjpandAdjp', 'AdjpaAdjp', 'AdjpandAdjpAdjp', 'AdvpaAdvp', 'AdvpandAdvp', 'CLa2CL', 'CLaCL', 'CLandCL2', 'CjpAdvpCjpAdvp', 'CjpCjp', 'ClCl', 'ClCl2', 'ClClCl', 'ClClClCl', 'ClClClClCl', 'ClClClClClCl', 'ClClaClaClaClaCl', 'ClaClClaCl', 'ClaClaClCl', 'Conj11Np', 'Conj2Pp', 'Conj3Adjp', 'Conj3CL', 'Conj3Np', 'Conj3Pp', 'Conj4Adjp', 'Conj4CL', 'Conj4Np', 'Conj4Pp', 'Conj5CL', 'Conj5Np', 'Conj5Pp', 'Conj6Np', 'Conj6Pp', 'Conj7Np', 'Conj7Pp', 'Conj8Np', 'Conj9Np', 'IjpIjp', 'NP10NP', 'NP3NP', 'NPNPNPNPaNPNPNPNPNPaNPNPNPNPNP', 'NPNPNPNPaNPaNPaNP', 'NPNPNPaNPNPaNP', 'NPNPNPaNPaNP', 'NPNPNPaNPaNPaNP', 'NPNPaNPNPNPNPNPaNP', 'NPNPaNPNPNPaNP', 'NPNPaNPNPaNP', 'NPNPaNPNPaNPaNP', 'NPNPaNPaNPaNP', 'NPNPaNPaNPaNPaNP', 'NPNPaNPaNPaNPaNPaNP', 'NPaNPNP', 'NPaNPNPNP', 'NPaNPNPNPNP', 'NPaNPNPNPNPNP', 'NPaNPNPNPNPNPNP', 'NPaNPNPNPNPNPaNPNP', 'NPaNPNPNPNPNPaNPaNP', 'NPaNPNPNPNPaNP', 'NPaNPNPNPaNP', 'NPaNPNPaNP', 'NPaNPNPaNPNP', 'NPaNPNPaNPNPaNP', 'NPaNPNPaNPNPaNPaNP', 'NPaNPaNPNP', 'NPaNPaNPNPNPNPNPNPNPNPNPNPNP', 'NPaNPaNPNPNPaNP', 'NPaNPaNPNPaNP', 'NPaNPaNPNPaNPNPNPaNPaNP', 'NPaNPaNPNPaNPNPaNP', 'NPaNPaNPNPaNPaNP', 'NPaNPaNPaNPNP', 'NPaNPaNPaNPNPaNP', 'NPaNPaNPaNPaNPNPNP', 'NPaNPaNPaNPaNPNPaNP', 'NPnp4NP', 'NPnp5NP', 'NPofNP', 'Np5Np', 'NpNp5', 'NpNp6', 'NpNpNp', 'NpNpNp11', 'NpNpNpNp', 'NpNpNpNpNp', 'NpNpNpNpNpNp', 'NpNpNpNpNpNpNpaNp', 'NpNpNpNpNpNpaNp', 'NpNpNpNpNpaNp', 'NpNpNpNpNpaNpNp', 'NpNpNpNpNpaNpaNp', 'NpNpNpNpaNpNpaNp', 'NpNpaNpNp', 'NpaNp', 'NumpAndNump', 'NumpNump', 'NumpNumpNumpNump', 'NumpNumpNumpaNump', 'NumpNumpaNump', 'NumpNumpaNumpaNump', 'NumpaNumpNump', 'NumpaNumpNumpaNump', 'NumpaNumpaNump', 'NumpaNumpaNumpaNump', 'PP8PP', 'PP9PP', 'PPPP4', 'PPPP5', 'PPandPP', 'PpPp', 'PpPp9', 'PpPpPp', 'PpPpPpPp', 'PpPpPpPpPp', 'PpPpPpPpandPp', 'PpPpPpaPpaPpaPpaPp', 'PpPpPpandPp', 'PpPpPpandPpPp', 'PpPpaPpaPpaPp', 'PpPpandPpPp', 'PpaPpPpPpPpaPp', 'PpaPpPpaPp', 'PpandPpPp', 'QuanNP', 'Relp3Relp', 'Relp5Relp', 'RelpRelp', 'RelpandRelp', 'VP3VP', 'VPandVP', 'VpVp2V3', 'Vpvp2V1', 'aCLaCL', 'aCLaCLaCL', 'aNpaNp', 'aNpaNpaNp', 'aPpaPp', 'aPpaPpaPp', 'ppPP5PP', 'ppPP6PP', 'ppappPP5PP', 'vpVp2V2');
(: Ryder: headed structures have rules realized by diverse structural patterns (i.e., comprising mixed types of structures beyond simply conjunctions and repetitions of the same structure) :)
declare variable $headed-structure-rule := ('AdjX', 'AdjpAdvp', 'AdjpDet', 'AdjpNp', 'AdjpPp', 'AdjpofNp', 'AdvX', 'AdvpAdjp', 'AdvpCL', 'AdvpNp', 'AdvpNp2advp', 'AdvpNump', 'AdvpPp', 'AdvpPp2', 'AdvpRelp', 'AdvpandPp', 'CjpAdjp', 'CjpAdvp2Advp', 'DetAdjp', 'DetNP', 'DetNump', 'DetVp', 'IjpX', 'NPDet', 'NPandPP2np', 'NounX', 'NpAdjp', 'NpAdvp', 'NpCL', 'NpInf', 'NpNump', 'NpPart', 'NpPp', 'NpRelp', 'NumX', 'NumpAdjp', 'NumpDet', 'NumpNP', 'NumpPp', 'OmpNP', 'OmpRelp', 'PpAdvp', 'PpNp2Np', 'PpNump', 'PpNump2', 'PpRelp', 'PpandAdvp', 'PrepCL', 'PrepNp', 'PrepX', 'PtclCL', 'RelpNp', 'VerbX', 'advpCLtoAdvp', 'cjpCLx', 'cjpNp', 'cjpPp', 'ppCL', 'relCL', 'relNp');

declare variable $complex-clause-rule := ('2CLaCL', '2CLaCLaCL', 'CLa2CL', 'CLandCL2', 'ClCl', 'ClCl2', 'aCLaCL', 'aCLaCLaCL', 'cjpCLx', 'ppCL', 'AdvpCL', 'PtclCL');
(: Ryder: operator clause rules are a subset of complex clause rules. They involve "wrapper" or "operator" scope of the initial operator. 'ppCL' for example are typically subordinate clauses :)
declare variable $operator-clause-rule := ('AdvpCL', 'cjpCLx', 'PtclCL', 'ppCL');
(: 
- 'aCLaCL' includes many 'if x or y' constructions. Some of these could be analyzed as operators wrapping junction.
- 'CLa2CL' includes some apparent clause complexes (e.g., JOS 10:1), whereas others seem to be independant clauses. I assume '2CLaCL' is similar.

:)

declare function local:is-clause-rule($rule as node())
{
    if (contains($rule, '-')) then
        true()
    else
        false()
};

(:~~~ function definitions ~~~:)

(: build dependency relationship using @Head :)
(: figure out whether I can FIRST process the entire tree and restore dependency, or whether I should do so only at certain points in the more fine-grained processing :)
declare function local:build-dependency-tree($unprocessedElement as element())
{
    (: end condition for recursion is when leaf node is encountered:)
    
    
    
    
};

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
(:declare function local:attributes($node)
(\: FIXME: update attributes function based on macula hebrew changes since May 2022 :\)
{
    if (local:node-type($node) = 'm')
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
        $node/@Cat ! attribute class {lower-case(.)},
        $node/@Head ! attribute head {if (. = '0') then true() else false()},
        (\:$node/@nodeId ! attribute xml:id {concat('o', lower-case(.))}, (\: NOTE: corpus-specific prefix 'o' is added to nodeIds here :\):\)
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
        $node/@Greek ! attribute greek {.}
};
:)
(: process words :)

(: process phrases :)


(: process clause - assign roles by clause rule :)

declare function local:process-clause-complex($node, $passed-role)
{
    for $constituent at $index in $node
    return
        (: Ryder: if constituent is cjp, embed immediately following sibling :)
        if ($constituent/@Cat = ('cjp', 'rel')) then (: FIXME Ryder: this only fires on 'relp', not 'rel' or 'cjp'. Need to refactor starting from local:node-type() :)
            <wg
                class='scope'>{
                    attribute role {$passed-role},
                    $constituent, (: Ryder: embed the operator. I can't do local:node() here or it loops infinitely :)
                    $constituent/following-sibling::element()[1] ! local:node(.) (: Ryder: embed the subsequent sibling :)
                }</wg>
        else
            (: Ryder: handle sibling following cjp :)
            if ($constituent/preceding-sibling::element()[1]/@Cat = ('cjp', 'relp')) then
                <precedingSiblingWasCjp/>
            else
                <wg
                    class='complex'>{
                        $node/@Rule ! attribute rule {.},
                        attribute role {$passed-role},
                        $node/element() ! local:node(.)
                    }</wg>
};

declare function local:process-complex-node($node, $passed-role)
{
    (: check for $headed-structure-rule or $group-rule :)
    if ($node/@Rule = $headed-structure-rule) then
        (: Complex node has a head; subordinate siblings :)
        
        (: Ryder: I believe every @Head value is 0-indexed, whereas XPath positions are 1-indexed, so add 1 to @Head :)
        let $headIndex := $node/@Head + 1
        let $headChild := $node/child::Node[$headIndex]
        let $childrenBeforeHead := $headChild/preceding-sibling::*
        let $childrenAfterHead := $headChild/following-sibling::*
        return
            <wg
                class="headed">{
                    (:                $headChild/@*, (\: Ryder: Promote head child attributes :\):)
                    $node/@Rule ! attribute rule {.}, (: Ryder: TEMPORARY copy rule :)
                    attribute role {$passed-role},
                    
                    (: Ryder: Subordinate all other non-head children :)
                    
                    $headChild/element() ! local:node(.),
                    <wg
                        class="dependents">{
                            $childrenBeforeHead ! <wg
                                role="mod">{local:node(.)}</wg>,
                            $childrenAfterHead ! <wg
                                role="mod">{local:node(.)}</wg>
                        }</wg>
                }</wg>
    else
        if ($node/@Rule = $group-rule) then
            (: Complex node does not have a head; coordinate siblings :)
            <wg
                class='g'>{
                    $node/@Rule ! attribute rule {.},
                    attribute role {$passed-role},
                    $node/element() ! local:node(.)
                }</wg>
        else
            <error_unknown_complex_node>{$node/element() ! local:node(.)}</error_unknown_complex_node>
};

declare function local:node-type($node as element())
{
    if (not($node/@Rule)) then
        'non-rule-node'
    else
        (: Ryder: if a "clause" does not have a clause-function rule (e.g., 'S-V-O'), it is a clause complex :)
        if ($node/@Cat = 'CL' and not(local:is-clause-rule($node/@Rule)) or $node/@Rule = $headed-structure-rule) then
            'clause-complex'
        else
            if (local:is-clause-rule($node/@Rule)) then
                'clause'
            else
                if ($node/@Rule = $atomic-structure-rule) then
                    'atomic'
                else
                    if (not($node/@Rule = $atomic-structure-rule)) then
                        'complex'
                    else
                        '#error_Unknown_Rule'
};

(: Ryder: declare both 1-arg and 2-arg node-processing functions so the function can be called with or without the second argument. :)
declare function local:node($node as element()) {
    local:node($node, ())
};
declare function local:node($node as element(), $passed-role as xs:string?)
{
    switch (local:node-type($node))
        case "non-rule-node"
            return
                if ($node/m) then
                    $node/m ! <w>{
                            attribute role {$passed-role},
                            ./text()
                        }</w>
                else
                    if ($node/c) then
                        $node/c/m ! <w>{
                                attribute role {$passed-role},
                                ./text()
                            }</w>
                    else
                        $node/element() ! local:node(., $passed-role)
        
        case "clause"
            return
                let $clause-roles := tokenize(lower-case($node/@Rule), '-')
                return
                    <wg
                        class='cl'>{
                            $node/@Rule ! attribute rule {.},
                            for $clause-constituent at $index in $node/element()
                            let $constituent-role := $clause-roles[$index]
                            return
                                local:node($clause-constituent, $constituent-role)
                        }</wg>
        case "clause-complex"
            return
                local:process-clause-complex($node, $passed-role)
        case "atomic"
            return
                $node/element() ! local:node(., $passed-role)
        
        case "complex"
            return
                local:process-complex-node($node, $passed-role)
        default
        return
            <error3>{$node}</error3>
};

(: sentence :)

declare function local:straight-text($node)
{
    for $n at $i in $node//Node[local:node-type(.) = 'word']
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
            
            if (count($node/Node) > 1 or not($node/Node/@Cat = 'CL'))
            (: If the current node has multiple node children, OR it does not have a clause child :)
            then
                <wg
                    role="cl">{$node/Node ! local:node(.)}</wg>
                (: FIXME: This element is not always a clause; it is a top-level wrapper, and treating 'cl' as a role is a kind of display hack IMO that uses @role for something that is not a clausal role. :)
            else
                local:node($node/Node)
            
        }
    </sentence>
};

(:~~~ execution ~~~:)

processing-instruction xml-stylesheet {'href="../../macula-greek/Nestle1904/lowfat/treedown.css"'},
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