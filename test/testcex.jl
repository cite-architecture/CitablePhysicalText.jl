


@testset "Test DSETriple structure" begin
    cexline = "urn:cts:trmilli:tl.25.v1:1#urn:cite2:lycian:hc.v1:2007.02.0003@0.04848,0.09494,0.7129,0.07528#urn:cite2:trmilli:inscriptions.v1:TL25"    
    triple = fromcex(cexline)
    @test isa(triple, DSETriple)

end