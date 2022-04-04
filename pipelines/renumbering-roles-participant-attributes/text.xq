declare variable $mappings := db:open("morpheme-mappings");
declare variable $annotations := db:open("annotations");

declare function local:replace-frame($node){
    let $new-string := string-join(for $f in $node => substring(2, string-length($node) - 2) => tokenize(" ") return concat($f => substring(1, 3), string-join(for $id in $f => substring(4) => tokenize(";") return local:replace-id($id), ";"), " "))
    return concat("{", $new-string => substring(1, string-length($new-string) - 1), "}")    
};

declare function local:replace-ref($node){
  concat("{", string-join(for $id in tokenize($node => substring(2, string-length($node) - 2), " ") return local:replace-id($id), " "), "}")  
};

declare function local:replace-id($morphId){
  let $id := if ($mappings//*[@morphId = $morphId]) then $mappings//*:m[@morphId = $morphId]/@n else $morphId
  return $id
};


for $node in $annotations//node
where $node[@Frame or @SubjRef or @Ref]

return (if ($node[@Frame]) then replace node $node/@Frame with $node/@Frame => local:replace-frame(),
if ($node[@Ref]) then replace node $node/@Ref with $node/@Ref => local:replace-ref(),
if ($node[@SubjRef]) then replace node $node/@SubjRef with $node/@SubjRef => local:replace-ref())