@testset "Test structure of DSECollection" begin
    urn = Cite2Urn("urn:cite2:hmt:dse.v1:msBil4")
    label = "Collection of DSE records for Venetus A text of Proclus, Chrestomathy"
    multilines = """urn:cts:greekLit:tlg4036.tlg023.va:Homer.title|urn:cite2:hmt:vaimg.2017a:VA001RN_0002@0.1580,0.1633,0.4740,0.05302|urn:cite2:hmt:msA.v1:1r
    urn:cts:greekLit:tlg4036.tlg023.va:Homer.1|urn:cite2:hmt:vaimg.2017a:VA001RN_0002@0.1335,0.2054,0.4637,0.04139|urn:cite2:hmt:msA.v1:1r
    urn:cts:greekLit:tlg4036.tlg023.va:Homer.2|urn:cite2:hmt:vaimg.2017a:VA001RN_0002@0.1553,0.2292,0.4508,0.04678|urn:cite2:hmt:msA.v1:1r
    urn:cts:greekLit:tlg4036.tlg023.va:Homer.3|urn:cite2:hmt:vaimg.2017a:VA001RN_0002@0.1449,0.2620,0.4641,0.05869|urn:cite2:hmt:msA.v1:1r
    """
    triplelist = triples(multilines)
    coll = DSECollection(urn, label, triplelist)

    @test coll isa DSECollection
    @test citable(coll)
    @test urn(coll) == Cite2Urn("urn:cite2:hmt:dse.v1:msBil4")
    @test label(coll) == "Collection of DSE records for Venetus A text of Proclus, Chrestomathy"

end