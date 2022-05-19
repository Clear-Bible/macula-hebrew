(:
    Convert GBI trees to Lowfat format.

	NOTE: this should rarely be used now that the lowfat trees
	are being independently, but I am keeping it in the repo
	for documentation purposes and also for quality assurance,
	as a way of testing the lowfat trees against GBI as we
	move forward.

	If it is used, remember to do the following steps:

	- Search for duplicate IDs, removing the second GBI interpretation when there are duplicate subtrees.
	- Search for the single instance where a word is not in any word group, but directly in a sentence.
	- Do a diff to make sure things make sense.

:)


declare variable $retain-singletons := false();

declare function local:osisBook($nodeId)
{
if(string-length($nodeId) < 1)
then "error5"
else
    switch (xs:integer(substring($nodeId, 1, 2)))
        case 01
            return
                "Gen"
        case 02
            return
                "Exo"
        case 03
            return
                "Lev"
        case 04
            return
                "Num"
        case 05
            return
                "Deu"
        case 06
            return
                "Jos"
        case 07
            return
                "Jdg"
        case 08
            return
                "Rut"
        case 09
            return
                "1Sa"
        case 10
            return
                "2Sa"
        case 11
            return
                "1Ki"
        case 12
            return
                "2Ki"
        case 13
            return
                "1Ch"
        case 14
            return
                "2Ch"
        case 15
            return
                "Ezr"
        case 16
            return
                "Neh"
        case 17
            return
                "Est"
        case 18
            return
                "Job"
        case 19
            return
                "Psa"
        case 20
            return
                "Pro"
        case 21
            return
                "Ecc"
        case 22
            return
                "Sng"
        case 23
            return
                "Isa"
        case 24
            return
                "Jer"
        case 25
            return
                "Lam"
        case 26
            return
                "Ezk"
        case 27
            return
                "Dan"
        case 28
            return
                "HOS"
        case 29
            return
                "Jol"
        case 30
            return
                "Amo"
        case 31
            return
                "Oba"
        case 32
            return
                "Jon"
        case 33
            return
                "Mic"
        case 34
            return
                "Nam"
        case 35
            return
                "Hab"
        case 36
            return
                "Zep"
        case 37
            return
                "Hag"
        case 38
            return
                "Zec"
        case 39
            return
                "Mal"
        default return
            "###"
};

declare function local:verbal-noun-type($node)
(:  This realy doesn't work yet. Not even close. :)
{
    switch ($node/parent::Node/@Cat)
        case 'adjp'
            return
                attribute type {'adjectival'}
        case 'advp'
            return
                attribute type {'adverbial'}
        case 'np'
            return
                attribute type {'nominal'}
        default return
            attribute type {'?'}
};

declare function local:head($node)
{
    if ($node)
    then
        let $preceding := count($node/preceding-sibling::Node)
        let $following := count($node/following-sibling::Node)
        return
            if ($preceding + $following > 0)
            then
                if ($preceding = $node/parent::*/@Head and $node/parent::*/@Cat != 'conj')
                then
                    attribute head {true()}
                else
                    ()
            else
                local:head($node/parent::*)
    else
        ()

};

declare function local:attributes($node)
{
    $node/@ID ! attribute ID {lower-case(.)},
    $node/@Cat ! attribute class {lower-case(.)},
    $node/@Head ! attribute Head {if (. = '0') then true() else false()},
    $node/@nodeId ! attribute nodeId {lower-case(.)},
    $node/@Rule ! attribute Rule {lower-case(.)},
    $node/@n ! attribute n {lower-case(.)},
    $node/@morphId ! attribute morphId {lower-case(.)},
    $node/@Unicode ! attribute Unicode {lower-case(.)},
    $node/@morph ! attribute morph {.},
    $node/@lang ! attribute lang {.},
    $node/@lemma ! attribute lemma {.},
    $node/@pos ! attribute pos {lower-case(.)},
    $node/@gender ! attribute gender {lower-case(.)},
    $node/@number ! attribute number {lower-case(.)},
    $node/@state ! attribute state {lower-case(.)},
    $node/@stem ! attribute stem {lower-case(.)},
    $node/@person ! attribute person {lower-case(.)},
    $node/@after
};

declare function local:osisId($nodeId)
{
if(string-length($nodeId) < 1) 
then "error6NoIDFoundInNode"
else
    concat(local:osisBook($nodeId),
    ".",
    xs:integer(substring($nodeId, 3, 3)),
    ".",
    xs:integer(substring($nodeId, 6, 3)),
    "!",
    xs:integer(substring($nodeId, 9, 3))
    )
};


declare function local:osisVerseId($nodeId)
{
if(string-length($nodeId) < 1) 
then "error7"
else
    concat(local:osisBook($nodeId),
    ".",
    xs:integer(substring($nodeId, 3, 3)),
    ".",
    xs:integer(substring($nodeId, 6, 3))
    )
};

declare function local:oneword($node)
(: If the Node governs a single word, return that word. :)
{
    if (count($node/Node) > 1)
    then
        ()
    else
        if ($node/Node)
        then
            local:oneword($node/Node)
        else
            $node
};

declare function local:sub-CL-adjunct($node)
{
    
    
    
};

declare function local:sub-CL-adjunct-parent($node)
{
    
    let $first := $node/Node[1]
    let $second := $node/Node[2]
    return
        if ($first[@Rule = 'sub-CL']) then
            <wg>
                {
                    local:attributes($second),
                    <!-- one -->,
                    $first ! local:node(.),
                    $second/Node ! local:node(.)
                }
            </wg>
        else
            if ($second[@Rule = 'sub-CL']) then
                <wg>
                    {
                        local:attributes($first),
                        <!-- two -->,
                        $first/Node ! local:node(.),
                        $second ! local:node(.)
                    }
                </wg>
            else
                <error2>{"Something went wrong.", "First:", $first, "Second:", $second}</error2>
};

declare function local:is-worth-preserving($clause)
{
    local:node-type($clause/parent::*) = 'role'
    or $clause/@Rule = 'sub-CL'
    or not($clause/@Rule = ('ClCl', 'ClCl2'))
};

declare function local:clause($node)
(:  This is probably too simple as written - need to do restructuring of clauses based on @rule attributes  :)
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

declare function local:rclause($node)
{
    if (local:is-worth-preserving($node))
    then
        <wg
            clauseType='relative'>
            {
                local:attributes($node),
                $node/Node ! local:node(.)
            }
        </wg>
    else
        $node/Node ! local:node(.)
};

declare function local:compound($nodeWithCChild)
{
(: If a node has a <c> child, it is the only child :)
    <wg
        class='compound'>
        {
            local:attributes($nodeWithCChild),
            $nodeWithCChild//m ! local:m(.)
        }
    </wg>
};

declare function local:phrase($node)
{
    if (local:oneword($node))
    then
        (local:m(local:oneword($node)/m)) (: PICKING UP: running into problems with oneword - probably when it hits a <c> element :)
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
    let $role := attribute role {lower-case($node/@Cat)}
    return
        if (local:oneword($node))
        then
            (local:m-with-role(local:oneword($node)/m, $role))
        else
            if (count($node/Node) > 1)
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

declare function local:m($m as element(m))
{
    local:m-with-role($m, ()) 
};

declare function local:m-with-role($m as element(), $role)
(: $role can contain a role attribute or a null sequence :)
{
    if(name($m) = 'Node')
    then
        element error10 {$role, $m, 'error location id:', data($m/@n)}
    else if(name($m) = 'c')
    then
        element error12 {$role, $m, 'error location id:', data($m/@n)}    
    else if ($m/*)
    then
        (element error1 {$role, $m})
    else
        <w osisId='{local:osisId($m/ancestor::Node[1]/@nodeId)}'>
            {
                (: get the @Cat etc. from the ancestor::Node[1] :)
                $role,
                $m/ancestor::Node[1]/@morphId,
                $m/ancestor::Node[1]/@Cat,
                $m/ancestor::Node[1]/@Unicode,
                $m/ancestor::Node[1]/@nodeId,
                local:attributes($m),
                string($m/text()),
                'parent: ',
                $m//parent::*,
                ':parent'
                
            }
        </w>
};

declare function local:node-type($node as element(Node))
{
    if ($node/c)
    then 
        "compound"
    else if ($node/m and not($node/c))
    then
        "word"
    else
        switch ($node/@Cat)
            case "CL"
                return
                    "clause"
            case "S"
            case "V"
            case "O"
            case "O2"
            case "P"
            case "PP"
            case "ADV"
                return
                    "role"
            case "relp"
                return
                    "rclause"
            case "pp"
            case "np"
            case "vp"
            case "omp"
            case "adjp"
            case "nump"
            case "cjp"
            case "advp"
            case "vp"
            case "ijp"
                return
                    "phrase"
            case "prep"
            case "noun"
            case "verb"
            case "om"
            case "art"
            case "cj"
            case "adj"
            case "num"
            case "rel"
            case "pron"
            case "adv"
            case "ij"
                return
                    "nonPhrase"
            default
                return
                    "#error4_Unknown_Category"
};

declare function local:node($node as element(Node))
{
    switch (local:node-type($node))
        case "compound"
            return
                local:compound($node/c)
        case "word"
            return
                local:m($node/m)
        case "phrase"
            return
                local:phrase($node)
        case "rclause"
            return
                local:rclause($node)
        case "role"
            return
                local:role($node)
        case "clause"
            return
                local:clause($node)
        default
        return <error3>{$node}</error3>
};

declare function local:straight-text($node)
{
    for $n at $i in $node//Node[local:node-type(.) = 'word']
        order by $n/@morphId
    return
        string($n/m/text())
};

declare function local:sentence($node)
{
    <sentence>
        {
            <p>
                {
                    for $verse in distinct-values($node//Node/@morphId ! local:osisVerseId(.))
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
                {local:straight-text($node)}
            </p>,
            
            if (count($node/Node) > 1 or not($node/Node/@Cat = 'CL'))
            (: If the current node has multiple node children, OR it does not have a clause child :)
            then
                <wg
                    role="cl">{$node/Node ! local:node(.)}</wg>
            else
                local:node($node/Node)
            
        }
    </sentence>
};

processing-instruction xml-stylesheet {'href="hebrew-treedown.css"'},
processing-instruction xml-stylesheet {'href="hebrew-boxwood.css"'},
<book>
    {
        (:
            If a sentence has multiple interpretations, Sentence/Trees may contain
            multiple Tree nodes.  We want to specify which interpretation to prefer.
        :)
        let $interpretationToPrefer := 1
        for $sentence in //Tree[$interpretationToPrefer]/Node
        return
            local:sentence($sentence)
    }
</book>