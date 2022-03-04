var documenterSearchIndex = {"docs":
[{"location":"apis/#API-documentation","page":"API documentation","title":"API documentation","text":"","category":"section"},{"location":"apis/","page":"API documentation","title":"API documentation","text":"DSETriple\ntriple\ntriples \npassage\nimage\nsurface\nDSECollection","category":"page"},{"location":"apis/#CitablePhysicalText.DSETriple","page":"API documentation","title":"CitablePhysicalText.DSETriple","text":"Citable relations of text passage, text-bearing surface and documentary image.\n\n\n\n\n\n","category":"type"},{"location":"apis/#CitablePhysicalText.triple","page":"API documentation","title":"CitablePhysicalText.triple","text":"Compose a DSETriple from delimited-text source.\n\ntriple(src; delimiter)\n\n\n\n\n\n\n","category":"function"},{"location":"apis/#CitablePhysicalText.triples","page":"API documentation","title":"CitablePhysicalText.triples","text":"Compose a Vector of DSETriples from delimited-text source.\n\ntriples(src; delimiter)\n\n\n\n\n\n\nCompose a Vector of DSETriples from delimited-text source.\n\ntriples(lines; delimiter)\n\n\n\n\n\n\n","category":"function"},{"location":"apis/#CitablePhysicalText.passage","page":"API documentation","title":"CitablePhysicalText.passage","text":"Return passage field of trip.\n\npassage(trip)\n\n\n\n\n\n\n","category":"function"},{"location":"apis/#CitablePhysicalText.image","page":"API documentation","title":"CitablePhysicalText.image","text":"Return image field of trip.\n\nimage(trip)\n\n\n\n\n\n\n","category":"function"},{"location":"apis/#CitablePhysicalText.surface","page":"API documentation","title":"CitablePhysicalText.surface","text":"Return surface field of trip.\n\nsurface(trip)\n\n\n\n\n\n\n","category":"function"},{"location":"apis/#CitablePhysicalText.DSECollection","page":"API documentation","title":"CitablePhysicalText.DSECollection","text":"A citable object wrapping a set of DSETriples.\n\n\n\n\n\n","category":"type"},{"location":"apis/","page":"API documentation","title":"API documentation","text":"Retrieval:","category":"page"},{"location":"apis/","page":"API documentation","title":"API documentation","text":"surfaces\npassages\nimages\ntextsforsurface\ntextsforimage\nsurfacesfortext\nsurfacesforimage\nimagesfortext\nimagesforsurface","category":"page"},{"location":"apis/#CitablePhysicalText.surfaces","page":"API documentation","title":"CitablePhysicalText.surfaces","text":"Find unique values for surface field of a collection.\n\nsurfaces(dse)\n\n\n\n\n\n\n","category":"function"},{"location":"apis/#CitablePhysicalText.passages","page":"API documentation","title":"CitablePhysicalText.passages","text":"Find unique values for passage field of a collection.\n\npassages(dse; keeppassage)\n\n\n\n\n\n\n","category":"function"},{"location":"apis/#CitablePhysicalText.images","page":"API documentation","title":"CitablePhysicalText.images","text":"Find unique values for image field of a collection.\n\nimages(dse; keepsubref)\n\n\n\n\n\n\n","category":"function"},{"location":"apis/#CitablePhysicalText.textsforsurface","page":"API documentation","title":"CitablePhysicalText.textsforsurface","text":"Find text passages on surface surf\n\ntextsforsurface(surf, dse)\n\n\n\n\n\n\n","category":"function"},{"location":"apis/#CitablePhysicalText.textsforimage","page":"API documentation","title":"CitablePhysicalText.textsforimage","text":"Find text passages for image(s) identified by URN.\n\ntextsforimage(img, dse; keepsubref)\n\n\n\n\n\n\n","category":"function"},{"location":"apis/#CitablePhysicalText.surfacesfortext","page":"API documentation","title":"CitablePhysicalText.surfacesfortext","text":"Find surfaces for text passage(s) identified by URN.\n\nsurfacesfortext(txt, dse; keepsubref)\n\n\n\n\n\n\n","category":"function"},{"location":"apis/#CitablePhysicalText.surfacesforimage","page":"API documentation","title":"CitablePhysicalText.surfacesforimage","text":"Find surfaces for image(s) identified by URN.\n\nsurfacesforimage(img, dse; keepsubref)\n\n\n\n\n\n\n","category":"function"},{"location":"apis/#CitablePhysicalText.imagesfortext","page":"API documentation","title":"CitablePhysicalText.imagesfortext","text":"Find surfaces for text passage(s) identified by URN.\n\nimagesfortext(txt, dse; keepsubref)\n\n\n\n\n\n\n","category":"function"},{"location":"apis/#CitablePhysicalText.imagesforsurface","page":"API documentation","title":"CitablePhysicalText.imagesforsurface","text":"Find surfaces for text passage(s) identified by URN.\n\nimagesforsurface(surf, dse; keepsubref)\n\n\n\n\n\n\n","category":"function"},{"location":"dsetriple/#The-DSETriple","page":"The DSETriple","title":"The DSETriple","text":"","category":"section"},{"location":"dsetriple/","page":"The DSETriple","title":"The DSETriple","text":"Construct a DSETriple from a triple of URN values.","category":"page"},{"location":"dsetriple/","page":"The DSETriple","title":"The DSETriple","text":"using CitablePhysicalText\nusing CitableObject\nusing CitableText\n\npsg = CtsUrn(\"urn:cts:trmilli:tl.25.v1:1\")\nimg = Cite2Urn(\"urn:cite2:lycian:hc.v1:2007.02.0003@0.04848,0.09494,0.7129,0.07528\")\nsurf = Cite2Urn(\"urn:cite2:trmilli:inscriptions.v1:TL25\")\ntriple = DSETriple(psg, img, surf)","category":"page"},{"location":"dsetriple/","page":"The DSETriple","title":"The DSETriple","text":"Use these functions to extract particular fields.","category":"page"},{"location":"dsetriple/","page":"The DSETriple","title":"The DSETriple","text":"passage(triple)","category":"page"},{"location":"dsetriple/","page":"The DSETriple","title":"The DSETriple","text":"image(triple)","category":"page"},{"location":"dsetriple/","page":"The DSETriple","title":"The DSETriple","text":"surface(triple)","category":"page"},{"location":"dsetriple/","page":"The DSETriple","title":"The DSETriple","text":"note: A note on URN comparison\nNote that since each component of the triple is a URN, you can test it with URN logic, as the following example illustrates.","category":"page"},{"location":"dsetriple/","page":"The DSETriple","title":"The DSETriple","text":"tl25 = CtsUrn(\"urn:cts:trmilli:tl.25.v1:\")\nurncontains(tl25, passage(triple))","category":"page"},{"location":"retrieval/","page":"Searching DSECollections","title":"Searching DSECollections","text":"root = pwd() |> dirname |> dirname","category":"page"},{"location":"retrieval/#Searching-DSECollections","page":"Searching DSECollections","title":"Searching DSECollections","text":"","category":"section"},{"location":"retrieval/#Finding-unique-values-for-each-field-of-a-DSETriple","page":"Searching DSECollections","title":"Finding unique values for each field of a DSETriple","text":"","category":"section"},{"location":"retrieval/","page":"Searching DSECollections","title":"Searching DSECollections","text":"The CitablePhysicalText package includes functions for querying a DSECollection.  We'll load a sample dataset from the file test/assets/proclusdse.cex in this github repository.","category":"page"},{"location":"retrieval/","page":"Searching DSECollections","title":"Searching DSECollections","text":"using CitableBase\nusing CitablePhysicalText\nf = joinpath(root, \"test\", \"assets\", \"proclusdse.cex\")\ndsecoll = fromcex(f, DSECollection, FileReader)","category":"page"},{"location":"retrieval/","page":"Searching DSECollections","title":"Searching DSECollections","text":"You can find the unique list of URNs for each field of the collection's triples with the functions surfaces, images and texts.","category":"page"},{"location":"retrieval/","page":"Searching DSECollections","title":"Searching DSECollections","text":"surfaces(dsecoll)","category":"page"},{"location":"retrieval/","page":"Searching DSECollections","title":"Searching DSECollections","text":"The images function has an optional parameter defining whether or not to include subreferences.","category":"page"},{"location":"retrieval/","page":"Searching DSECollections","title":"Searching DSECollections","text":"images(dsecoll, keepsubref = false)","category":"page"},{"location":"retrieval/","page":"Searching DSECollections","title":"Searching DSECollections","text":"Similarly, the passages function has an optional parameter defining whether or not to include the passage component.","category":"page"},{"location":"retrieval/","page":"Searching DSECollections","title":"Searching DSECollections","text":"passages(dsecoll, keeppassage = false)","category":"page"},{"location":"retrieval/#Querying-by-field","page":"Searching DSECollections","title":"Querying by field","text":"","category":"section"},{"location":"retrieval/","page":"Searching DSECollections","title":"Searching DSECollections","text":"The following functions find values for one field of a DSETriple filtered by another field.","category":"page"},{"location":"retrieval/","page":"Searching DSECollections","title":"Searching DSECollections","text":"Find all text passages on a given surface:","category":"page"},{"location":"retrieval/","page":"Searching DSECollections","title":"Searching DSECollections","text":"using CitableObject\npage = Cite2Urn(\"urn:cite2:hmt:msA.v1:1r\")\ntextsforsurface(page, dsecoll)","category":"page"},{"location":"retrieval/","page":"Searching DSECollections","title":"Searching DSECollections","text":"Find all text passages indexed to a given image:","category":"page"},{"location":"retrieval/","page":"Searching DSECollections","title":"Searching DSECollections","text":"img = Cite2Urn(\"urn:cite2:hmt:vaimg.2017a:VA001RN_0002\")\ntextsforimage(img, dsecoll)","category":"page"},{"location":"retrieval/","page":"Searching DSECollections","title":"Searching DSECollections","text":"Find what pages a text occurs on:","category":"page"},{"location":"retrieval/","page":"Searching DSECollections","title":"Searching DSECollections","text":"using CitableText\nhomer = CtsUrn(\"urn:cts:greekLit:tlg4036.tlg023.va:Homer\")\nsurfacesfortext(homer, dsecoll)","category":"page"},{"location":"retrieval/","page":"Searching DSECollections","title":"Searching DSECollections","text":"Find what images illustrate a text:","category":"page"},{"location":"retrieval/","page":"Searching DSECollections","title":"Searching DSECollections","text":"homer = CtsUrn(\"urn:cts:greekLit:tlg4036.tlg023.va:Homer\")\nimagesfortext(homer, dsecoll)","category":"page"},{"location":"retrieval/","page":"Searching DSECollections","title":"Searching DSECollections","text":"Find surfaces illustrated by an image:","category":"page"},{"location":"retrieval/","page":"Searching DSECollections","title":"Searching DSECollections","text":"surfacesforimage(img, dsecoll)","category":"page"},{"location":"retrieval/","page":"Searching DSECollections","title":"Searching DSECollections","text":"Find images illustrating a surface;","category":"page"},{"location":"retrieval/","page":"Searching DSECollections","title":"Searching DSECollections","text":"imagesforsurface(page, dsecoll)","category":"page"},{"location":"dsecollection/#The-DSECollection","page":"The DSECollection","title":"The DSECollection","text":"","category":"section"},{"location":"dsecollection/","page":"The DSECollection","title":"The DSECollection","text":"The DSECollection contains a human-readable label, and list of DSETriples, and is identified by Cite2Urn.  You can construct one manually, as in this example.","category":"page"},{"location":"dsecollection/","page":"The DSECollection","title":"The DSECollection","text":"using CitablePhysicalText\nusing CitableObject\nusing CitableText\n\ndseurn = Cite2Urn(\"urn:cite2:hmt:dse.v1:msBil4\")\ndselabel = \"Collection of DSE records for Venetus A text of Proclus, Chrestomathy\"\n\ntriplelines = \"\"\"urn:cts:greekLit:tlg4036.tlg023.va:Homer.title|urn:cite2:hmt:vaimg.2017a:VA001RN_0002@0.1580,0.1633,0.4740,0.05302|urn:cite2:hmt:msA.v1:1r\nurn:cts:greekLit:tlg4036.tlg023.va:Homer.1|urn:cite2:hmt:vaimg.2017a:VA001RN_0002@0.1335,0.2054,0.4637,0.04139|urn:cite2:hmt:msA.v1:1r\nurn:cts:greekLit:tlg4036.tlg023.va:Homer.2|urn:cite2:hmt:vaimg.2017a:VA001RN_0002@0.1553,0.2292,0.4508,0.04678|urn:cite2:hmt:msA.v1:1r\nurn:cts:greekLit:tlg4036.tlg023.va:Homer.3|urn:cite2:hmt:vaimg.2017a:VA001RN_0002@0.1449,0.2620,0.4641,0.05869|urn:cite2:hmt:msA.v1:1r\n\"\"\"\ntriplelist = triples(triplelines)\ncoll = DSECollection(dseurn, dselabel, triplelist)","category":"page"},{"location":"dsecollection/","page":"The DSECollection","title":"The DSECollection","text":"Alternatively, you can construct a DSECollection directly from a CEX source (as illustrated below, and on the following page).","category":"page"},{"location":"dsecollection/#A-citable-object","page":"The DSECollection","title":"A citable object","text":"","category":"section"},{"location":"dsecollection/","page":"The DSECollection","title":"The DSECollection","text":"The DSECollection is a citable object, and therefore fufills traits for citation, comparison using URN logic, and CEX serialization, as you can verify with these functions from CitableBase.","category":"page"},{"location":"dsecollection/","page":"The DSECollection","title":"The DSECollection","text":"using CitableBase\ncitable(coll)","category":"page"},{"location":"dsecollection/","page":"The DSECollection","title":"The DSECollection","text":"urncomparable(coll)","category":"page"},{"location":"dsecollection/","page":"The DSECollection","title":"The DSECollection","text":"cexserializable(coll)","category":"page"},{"location":"dsecollection/#Citation","page":"The DSECollection","title":"Citation","text":"","category":"section"},{"location":"dsecollection/","page":"The DSECollection","title":"The DSECollection","text":"You can therefore apply the urn and label functions of CitableBase to it.","category":"page"},{"location":"dsecollection/","page":"The DSECollection","title":"The DSECollection","text":"urn(coll)","category":"page"},{"location":"dsecollection/","page":"The DSECollection","title":"The DSECollection","text":"label(coll)","category":"page"},{"location":"dsecollection/#URN-comparison","page":"The DSECollection","title":"URN comparison","text":"","category":"section"},{"location":"dsecollection/","page":"The DSECollection","title":"The DSECollection","text":"DSECollections can be compared using URN logic.","category":"page"},{"location":"dsecollection/","page":"The DSECollection","title":"The DSECollection","text":"dupe = coll\nurnequals(coll, dupe)","category":"page"},{"location":"dsecollection/","page":"The DSECollection","title":"The DSECollection","text":"Since a DSECollection should be uniquely identified, however, it is more likely that you'll want to compare a URN to the DSECollection's URN.","category":"page"},{"location":"dsecollection/","page":"The DSECollection","title":"The DSECollection","text":"common = dropobject(dseurn)\nurncontains(common, urn(coll))","category":"page"},{"location":"dsecollection/","page":"The DSECollection","title":"The DSECollection","text":"urnsimilar(common, urn(coll))","category":"page"},{"location":"dsecollection/#CEX-serialization","page":"The DSECollection","title":"CEX serialization","text":"","category":"section"},{"location":"dsecollection/","page":"The DSECollection","title":"The DSECollection","text":"collcex = cex(coll)","category":"page"},{"location":"dsecollection/","page":"The DSECollection","title":"The DSECollection","text":"fromcex(collcex, DSECollection) == coll","category":"page"},{"location":"#The-CitablePhysicalText-module","page":"Home","title":"The CitablePhysicalText module","text":"","category":"section"},{"location":"#Overview","page":"Home","title":"Overview","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"The CitablePhysicalText module works with texts in the context of a physical surface — a manuscript page, surface of an inscription, or column of a papyrus, for example —  that is illustrated by documentary images.   Its fundamental data structure, the DSETriple, associates triplets of text, surface and image.  The type is named DSETriple because this model is essential for a Diplomatic Scholarly Edition. Each component of the triple is a citable scholarly resources: the text is identified by CtsUrn; the surface and image are identified by Cite2Urn.","category":"page"},{"location":"","page":"Home","title":"Home","text":"The DSECollection is a citable object (as defined in CitableBase): it is identified by a URN, and has a human-readable label. It also has a list of DSETriples, and functions for querying the triples using URN logic.","category":"page"}]
}
