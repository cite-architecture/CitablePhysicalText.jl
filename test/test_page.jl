@testset "Test basic structure and citable trait of Page" begin
    u = Cite2Urn("urn:cite2:hmt:msA.v1:3r")
    img = Cite2Urn("urn:cite2:hmt:vaimg.2017a:VA003RN_0004")
    lbl = "folio 3, recto"
    rv = "recto"
    
    pg = MSPage(u, lbl, rv, img, 5)
    pg2 = MSPage(u, lbl, rv, img, 5)
    
    @test string(pg) == "<urn:cite2:hmt:msA.v1:3r> folio 3, recto"
    @test pg == pg2

    @test citable(pg)
    @test urntype(typeof(pg)) == Cite2Urn
    @test urn(pg) == u
    @test label(pg) == lbl
    
end


@testset "Test urn comparison trait on Page" begin
    u = Cite2Urn("urn:cite2:hmt:msA.v1:3r")
    coll = dropobject(u)
    img = Cite2Urn("urn:cite2:hmt:vaimg.2017a:VA003RN_0004")
    lbl = "folio 3, recto"
    rv = "recto"
    
    pg = MSPage(u, lbl, rv, img, 5)
    @test urncomparable(pg)
    @test urnequals(coll, pg) == false
    @test urncontains(coll, pg) 
    @test urnsimilar(coll, pg) 
end



@testset "Test Cex trait on Page" begin
    u = Cite2Urn("urn:cite2:hmt:msA.v1:3r")
    coll = dropobject(u)
    img = Cite2Urn("urn:cite2:hmt:vaimg.2017a:VA003RN_0004")
    lbl = "folio 3, recto"
    rv = "recto"
    
    pg = MSPage(u, lbl, rv, img, 5)
    @test cexserializable(pg)
    expected = "urn:cite2:hmt:msA.v1:3r|folio 3, recto|recto|urn:cite2:hmt:vaimg.2017a:VA003RN_0004|5"
    @test cex(pg) == expected
    @test fromcex(cex(pg), MSPage) == pg
end