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

string-join(local:headers(), "	")
,
for $w in //w
order by $w/@xml:id
return string-join((local:row($w)), "	")