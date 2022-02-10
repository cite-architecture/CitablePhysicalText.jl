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
    u = Cite2Urn("urn:cite2:hmt:msA.v1:3r")
    img = Cite2Urn("urn:cite2:hmt:vaimg.2017a:VA003RN_0004")
    lbl = "folio 3, recto"
    rv = "recto"
    pg = MSPage(u, lbl, rv, img, 5)

    codex1 = codex([pg])
    @test cexserializable(codex1)

    expected = "#!datamodels\nCollection|Model|Label|Description\nurn:cite2:hmt:msA.v1:|urn:cite2:hmt:datamodels.v1:codexmodel|Codex with 1 page\n\n#!citeproperties\nProperty|Label|Type|Authority list\nurn:cite2:hmt:msA.v1.urn:|URN|Cite2Urn|\nurn:cite2:hmt:msA.v1.label:|Label|String|\nurn:cite2:hmt:msA.v1.rv:|Recto or verso|String|recto,verso\nurn:cite2:hmt:msA.v1.image:|TBS image|Cite2Urn|\nurn:cite2:hmt:msA.v1.sequence:|Page seqence|Number|\n\n#!citedata\nurn|label|rv|image|sequence\nurn:cite2:hmt:msA.v1:3r|folio 3, recto|recto|urn:cite2:hmt:vaimg.2017a:VA003RN_0004|5"
    @test strip(cex(codex1))   == strip(expected)
    @test length(fromcex(cex(codex1), Codex)) == length(codex1)


    @test_broken fromcex(cex(codex1), Codex) == codex1
end

@testset "Test julia collection traits of `Codex" begin
    # iterate, length, eltype, filter, reverse
    f = joinpath(pwd(), "assets", "burney86-sample.cex")
    ms = fromcex(f, Codex, FileReader)
    @test eltype(ms) == MSPage
    @test length(ms) == 9
    @test typeof(collect(ms))  <: Vector
    @test length(filter(p -> p.rv == "recto", ms) |> collect) == 5
    @test reverse(ms)[1] |> urn == Cite2Urn("urn:cite2:citebl:burney86pages.v1:5r")

    windoid =  slidingwindow(ms)
    @test windoid[1][1] |> urn == Cite2Urn("urn:cite2:citebl:burney86pages.v1:1r")
    @test windoid[end][2] |> urn == Cite2Urn("urn:cite2:citebl:burney86pages.v1:5r")
end

