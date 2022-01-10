@testset "Test URN retrieval" begin
    dseurn = Cite2Urn("urn:cite2:hmt:dse.v1:msBil4")
    dselabel = "Collection of DSE records for Venetus A text of Proclus, Chrestomathy"
    multilines = """urn:cts:greekLit:tlg4036.tlg023.va:Homer.title|urn:cite2:hmt:vaimg.2017a:VA001RN_0002@0.1580,0.1633,0.4740,0.05302|urn:cite2:hmt:msA.v1:1r
    urn:cts:greekLit:tlg4036.tlg023.va:Homer.1|urn:cite2:hmt:vaimg.2017a:VA001RN_0002@0.1335,0.2054,0.4637,0.04139|urn:cite2:hmt:msA.v1:1r
    urn:cts:greekLit:tlg4036.tlg023.va:Homer.2|urn:cite2:hmt:vaimg.2017a:VA001RN_0002@0.1553,0.2292,0.4508,0.04678|urn:cite2:hmt:msA.v1:1r
    urn:cts:greekLit:tlg4036.tlg023.va:Homer.3|urn:cite2:hmt:vaimg.2017a:VA001RN_0002@0.1449,0.2620,0.4641,0.05869|urn:cite2:hmt:msA.v1:1r
    """
    triplelist = triples(multilines)
    coll = DSECollection(dseurn, dselabel, triplelist)

    surf = Cite2Urn("urn:cite2:hmt:msA.v1:1r")
    txt = CtsUrn("urn:cts:greekLit:tlg4036.tlg023.va:Homer")
    img = Cite2Urn("urn:cite2:hmt:vaimg.2017a:VA001RN_0002")

    @test length(textsforsurface(surf, coll) ) == 4
    @test length(textsforimage(img, coll)) == 4

    @test length(surfacesfortext(txt, coll)) == 1
    @test length(surfacesforimage(img, coll)) == 1


    @test length(imagesfortext(txt, coll)) == 4
    @test length(imagesforsurface(surf, coll)) == 4

    
    
end