# The `DSECollection`

The `DSECollection` contains a human-readable label, and list of `DSETriple`s, and is identified by `Cite2Urn`.  You can construct one manually, as in this example.

```@example coll
using CitablePhysicalText
using CitableObject
using CitableText

dseurn = Cite2Urn("urn:cite2:hmt:dse.v1:msBil4")
dselabel = "Collection of DSE records for Venetus A text of Proclus, Chrestomathy"

triplelines = """urn:cts:greekLit:tlg4036.tlg023.va:Homer.title|urn:cite2:hmt:vaimg.2017a:VA001RN_0002@0.1580,0.1633,0.4740,0.05302|urn:cite2:hmt:msA.v1:1r
urn:cts:greekLit:tlg4036.tlg023.va:Homer.1|urn:cite2:hmt:vaimg.2017a:VA001RN_0002@0.1335,0.2054,0.4637,0.04139|urn:cite2:hmt:msA.v1:1r
urn:cts:greekLit:tlg4036.tlg023.va:Homer.2|urn:cite2:hmt:vaimg.2017a:VA001RN_0002@0.1553,0.2292,0.4508,0.04678|urn:cite2:hmt:msA.v1:1r
urn:cts:greekLit:tlg4036.tlg023.va:Homer.3|urn:cite2:hmt:vaimg.2017a:VA001RN_0002@0.1449,0.2620,0.4641,0.05869|urn:cite2:hmt:msA.v1:1r
"""
triplelist = triples(triplelines)
coll = DSECollection(dseurn, dselabel, triplelist)
```

Alternatively, you can construct a `DSECollection` directly from a CEX source (as illustrated below).

## A citable object

The `DSECollection` is a citable object, and therefore fufills traits for *citation*, *comparison using URN logic*, and *CEX serialization*, as you can verify with these functions from `CitableBase`.

```@example coll
using CitableBase
citable(coll)
```

```@example coll
urncomparable(coll)
```

```@example coll
cexserializable(coll)
```



### Citation

You can therefore apply the `urn` and `label` functions of `CitableBase` to it.

```@example coll
urn(coll)
```

```@example coll
label(coll)
```

### URN comparison

`DSECollection`s can be compared using URN logic.

```@example coll
dupe = coll
urnequals(coll, dupe)
```

Since a `DSECollection` should be uniquely identified, however, it is more likely that you'll want to compare a URN to the `DSECollection`'s URN.

```@example coll
common = dropobject(dseurn)
urncontains(common, urn(coll))
```

```@example coll
urnsimilar(common, urn(coll))
```

### CEX serialization
