@testset "Test structure of DSECollection" begin
    dseurn = Cite2Urn("urn:cite2:hmt:dse.v1:msBil4")
    dselabel = "Collection of DSE records for Venetus A text of Proclus, Chrestomathy"
    multilines = """urn:cts:greekLit:tlg4036.tlg023.va:Homer.title|urn:cite2:hmt:vaimg.2017a:VA001RN_0002@0.1580,0.1633,0.4740,0.05302|urn:cite2:hmt:msA.v1:1r
    urn:cts:greekLit:tlg4036.tlg023.va:Homer.1|urn:cite2:hmt:vaimg.2017a:VA001RN_0002@0.1335,0.2054,0.4637,0.04139|urn:cite2:hmt:msA.v1:1r
    urn:cts:greekLit:tlg4036.tlg023.va:Homer.2|urn:cite2:hmt:vaimg.2017a:VA001RN_0002@0.1553,0.2292,0.4508,0.04678|urn:cite2:hmt:msA.v1:1r
    urn:cts:greekLit:tlg4036.tlg023.va:Homer.3|urn:cite2:hmt:vaimg.2017a:VA001RN_0002@0.1449,0.2620,0.4641,0.05869|urn:cite2:hmt:msA.v1:1r
    """
    triplelist = triples(multilines)
    coll = DSECollection(dseurn, dselabel, triplelist)

    @test coll isa DSECollection
    @test citable(coll)
    @test urn(coll) == Cite2Urn("urn:cite2:hmt:dse.v1:msBil4")
    @test label(coll) == "Collection of DSE records for Venetus A text of Proclus, Chrestomathy"
end


@testset "Test URN comparison on DSECollections" begin
    dse1urn = Cite2Urn("urn:cite2:hmt:dse.v1:msBil4")
    dse1label = "Collection of DSE records for Venetus A text of Proclus, Chrestomathy"
    dse2urn = Cite2Urn("urn:cite2:hmt:dse.v1:upsilon1_1_iliad")
    dse2label = "Collection of DSE records for Upsilon 1.1 text of the Iliad"

    dse1lines = """urn:cts:greekLit:tlg4036.tlg023.va:Homer.title|urn:cite2:hmt:vaimg.2017a:VA001RN_0002@0.1580,0.1633,0.4740,0.05302|urn:cite2:hmt:msA.v1:1r
    urn:cts:greekLit:tlg4036.tlg023.va:Homer.1|urn:cite2:hmt:vaimg.2017a:VA001RN_0002@0.1335,0.2054,0.4637,0.04139|urn:cite2:hmt:msA.v1:1r
    urn:cts:greekLit:tlg4036.tlg023.va:Homer.2|urn:cite2:hmt:vaimg.2017a:VA001RN_0002@0.1553,0.2292,0.4508,0.04678|urn:cite2:hmt:msA.v1:1r
    urn:cts:greekLit:tlg4036.tlg023.va:Homer.3|urn:cite2:hmt:vaimg.2017a:VA001RN_0002@0.1449,0.2620,0.4641,0.05869|urn:cite2:hmt:msA.v1:1r
    """
    dse1triples = triples(dse1lines)
    dse2lines = """urn:cts:greekLit:tlg0012.tlg001.e3:23.1#urn:cite2:hmt:e3bifolio.v1:E3_293v_294r@0.4863,0.4409,0.2771,0.05960#urn:cite2:hmt:e3.v1:294r
urn:cts:greekLit:tlg0012.tlg001.e3:23.2#urn:cite2:hmt:e3bifolio.v1:E3_293v_294r@0.5002,0.4775,0.2647,0.04167#urn:cite2:hmt:e3.v1:294r
urn:cts:greekLit:tlg0012.tlg001.e3:23.3#urn:cite2:hmt:e3bifolio.v1:E3_293v_294r@0.5030,0.4969,0.2643,0.04257#urn:cite2:hmt:e3.v1:294r
urn:cts:greekLit:tlg0012.tlg001.e3:23.4#urn:cite2:hmt:e3bifolio.v1:E3_293v_294r@0.5037,0.5223,0.2863,0.04656#urn:cite2:hmt:e3.v1:294r
"""
    dse2triples = triples(dse2lines, delimiter = "#")

    coll1 = DSECollection(dse1urn, dse1label, dse1triples)
    coll2 = DSECollection(dse2urn, dse2label, dse2triples)

    @test urncomparable(coll1)
    @test urnequals(coll1, coll2) == false
    common = dropobject(dse1urn)
    @test urncontains(common, urn(coll1))
    @test urnsimilar(common, urn(coll1))

end



@testset "Test CEX serialization on DSECollections" begin
    dseurn = Cite2Urn("urn:cite2:hmt:dse.v1:msBil4")
    dselabel = "Collection of DSE records for Venetus A text of Proclus, Chrestomathy"
    dataline = """urn:cts:greekLit:tlg4036.tlg023.va:Homer.title|urn:cite2:hmt:vaimg.2017a:VA001RN_0002@0.1580,0.1633,0.4740,0.05302|urn:cite2:hmt:msA.v1:1r
    """
    coll = DSECollection(dseurn, dselabel, triples(dataline))

    expectedcex = "#!datamodels\nCollection|Model|Label|Description\nurn:cite2:hmt:dse.v1:msBil4|urn:cite2:cite:datamodels.v1:dsemodel|Passage of text in a digital scholarly edition|Relations of text, manuscript page and documentary image for all edited texts\n\n#!citerelationset\nurn|urn:cite2:hmt:dse.v1:msBil4\nlabel|Collection of DSE records for Venetus A text of Proclus, Chrestomathy\npassage|imageroi|surface\nurn:cts:greekLit:tlg4036.tlg023.va:Homer.title|urn:cite2:hmt:vaimg.2017a:VA001RN_0002@0.1580,0.1633,0.4740,0.05302|urn:cite2:hmt:msA.v1:1r"
    @test cex(coll) == expectedcex

    # Test lazy parsing:
    @test length(fromcex(expectedcex, DSECollection, strict = false)) == 1

    # Test strict parsing:
    f = joinpath(pwd(), "assets", "hmt-2022k.cex")
    hmt = fromcex(f, DSECollection, FileReader)
    @test length(hmt) == 1
    hmtdse = hmt[1]
    @test urn(hmtdse) == Cite2Urn("urn:cite2:hmt:hmtdse.v1:all")
    @test label(hmtdse) == "Homer Multitext project indexing of digital scholarly editions"




end