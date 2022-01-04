
@testset "Test DSETriple structure" begin
    psg = CtsUrn("urn:cts:trmilli:tl.25.v1:1")
    img = Cite2Urn("urn:cite2:lycian:hc.v1:2007.02.0003@0.04848,0.09494,0.7129,0.07528")
    surf = Cite2Urn("urn:cite2:trmilli:inscriptions.v1:TL25")
    trip = DSETriple(psg, img, surf)
    @test passage(trip) == psg
    @test image(trip) == img
    @test surface(trip) == surf
end

@testset "Test constructor functions" begin
    cexsrc = "urn:cts:greekLit:tlg4036.tlg023.va:Homer.title|urn:cite2:hmt:vaimg.2017a:VA001RN_0002@0.1580,0.1633,0.4740,0.05302|urn:cite2:hmt:msA.v1:1r"
    trip = triple(cexsrc)
    @test trip isa DSETriple


    multilines = """urn:cts:greekLit:tlg4036.tlg023.va:Homer.title|urn:cite2:hmt:vaimg.2017a:VA001RN_0002@0.1580,0.1633,0.4740,0.05302|urn:cite2:hmt:msA.v1:1r
    urn:cts:greekLit:tlg4036.tlg023.va:Homer.1|urn:cite2:hmt:vaimg.2017a:VA001RN_0002@0.1335,0.2054,0.4637,0.04139|urn:cite2:hmt:msA.v1:1r
    urn:cts:greekLit:tlg4036.tlg023.va:Homer.2|urn:cite2:hmt:vaimg.2017a:VA001RN_0002@0.1553,0.2292,0.4508,0.04678|urn:cite2:hmt:msA.v1:1r
    urn:cts:greekLit:tlg4036.tlg023.va:Homer.3|urn:cite2:hmt:vaimg.2017a:VA001RN_0002@0.1449,0.2620,0.4641,0.05869|urn:cite2:hmt:msA.v1:1r
    """
    triplelist = triples(multilines)
    @test triplelist isa Vector{DSETriple}
    @test length(triplelist) == 4
end




