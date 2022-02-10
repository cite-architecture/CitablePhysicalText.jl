@testset "Test basic structure and citable trait of `Codex`" begin
    u = Cite2Urn("urn:cite2:hmt:msA.v1:3r")
    img = Cite2Urn("urn:cite2:hmt:vaimg.2017a:VA003RN_0004")
    lbl = "folio 3, recto"
    rv = "recto"
    pg = MSPage(u, lbl, rv, img, 5)

    codex = Codex([pg])
    @test codex isa Codex
    @test string(codex) == "Codex with 1 page"
    
    pg2 = MSPage(u, lbl, rv, img, 5)
    codex2 = Codex([pg2])
    @test codex == codex2

    @test citablecollection(codex)
end


@testset "Test urn comparison trait of `ImageCollection`" begin
    # urncomparable, urnequals, urncontains, urnsimilar
    u = Cite2Urn("urn:cite2:hmt:msA.v1:3r")
    img = Cite2Urn("urn:cite2:hmt:vaimg.2017a:VA003RN_0004")
    lbl = "folio 3, recto"
    rv = "recto"
    pg = MSPage(u, lbl, rv, img, 5)

    codex = Codex([pg])
    @test urncomparable(codex)
    collurn = dropobject(u)
    @test urnequals(collurn, codex) |> isempty
    @test urncontains(collurn, codex) |> length == 1
    @test urnsimilar(collurn, codex) |> length == 1
end


@testset "Test cex trait of `ImageCollection`" begin
    #cexserializable, cex, fromcex
end

@testset "Test julia collection traits of `ImageCollection" begin
    # iterate, length, eltype, filter, reverse
end


@testset "Test sliding windows on `ImageCollection`" begin
    
end
