@testset "Test basic structure and citable trait of `Codex`" begin
    u = Cite2Urn("urn:cite2:hmt:msA.v1:3r")
    img = Cite2Urn("urn:cite2:hmt:vaimg.2017a:VA003RN_0004")
    lbl = "folio 3, recto"
    rv = "recto"
    pg = MSPage(u, lbl, rv, img, 5)

    codex1 = codex([pg])
    @test codex1 isa Codex
    @test string(codex1) == "Codex with 1 page"
    
    pg2 = MSPage(u, lbl, rv, img, 5)
    codex2 = codex([pg2])
    @test codex1 == codex2

    @test citablecollection(codex1)
    @test citable(codex1)
    @test urntype(codex1) == Cite2Urn
    @test urn(codex1) == Cite2Urn("urn:cite2:hmt:msA.v1:")
    @test label(codex1) == "Codex with 1 page"


end


@testset "Test urn comparison trait of `Codex`" begin
    u = Cite2Urn("urn:cite2:hmt:msA.v1:3r")
    img = Cite2Urn("urn:cite2:hmt:vaimg.2017a:VA003RN_0004")
    lbl = "folio 3, recto"
    rv = "recto"
    pg = MSPage(u, lbl, rv, img, 5)

    codex1 = codex([pg])
    @test urncomparable(codex1)
    collurn = dropobject(u)
    @test urnequals(collurn, codex1) |> isempty
    @test urncontains(collurn, codex1) |> length == 1
    @test urnsimilar(collurn, codex1) |> length == 1
end


@testset "Test cex trait of `Codex`" begin
    #cexserializable, cex, fromcex
    u = Cite2Urn("urn:cite2:hmt:msA.v1:3r")
    img = Cite2Urn("urn:cite2:hmt:vaimg.2017a:VA003RN_0004")
    lbl = "folio 3, recto"
    rv = "recto"
    pg = MSPage(u, lbl, rv, img, 5)

    codex1 = codex([pg])
    @test cexserializable(codex1)
end

@testset "Test julia collection traits of `Codex" begin
    # iterate, length, eltype, filter, reverse
end


@testset "Test sliding windows on `Codex`" begin
    
end
