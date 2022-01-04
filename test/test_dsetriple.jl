
@testset "Test DSETriple structure" begin
    psg = CtsUrn("urn:cts:trmilli:tl.25.v1:1")
    img = Cite2Urn("urn:cite2:lycian:hc.v1:2007.02.0003@0.04848,0.09494,0.7129,0.07528")
    surf = Cite2Urn("urn:cite2:trmilli:inscriptions.v1:TL25")
    triple = DSETriple(psg, img, surf)
    @test triple.passage == psg
    @test triple.image == img
    @test triple.surface == surf
end



urn:cts:greekLit:tlg4036.tlg023.va:Homer.title|urn:cite2:hmt:vaimg.2017a:VA001RN_0002@0.1580,0.1633,0.4740,0.05302|urn:cite2:hmt:msA.v1:1r