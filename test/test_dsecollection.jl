@testset "Test structure of DSECollection" begin
    urn = Cite2Urn("urn:cite2:hmt:dse.v1:msBil4")
    label = "Collection of DSE records for Venetus A text of Proclus, Chrestomathy"
    trip1 = triple("urn:cts:greekLit:tlg4036.tlg023.va:Homer.title|urn:cite2:hmt:vaimg.2017a:VA001RN_0002@0.1580,0.1633,0.4740,0.05302|urn:cite2:hmt:msA.v1:1r")
    trip2 = triple("urn:cts:greekLit:tlg4036.tlg023.va:Homer.1|urn:cite2:hmt:vaimg.2017a:VA001RN_0002@0.1335,0.2054,0.4637,0.04139|urn:cite2:hmt:msA.v1:1r")
    coll = DSECollection(urn, label, [trip1, trip2])

    @test coll isa DSECollection

end