"A single page (one side of a folio) of a codex"
struct MSPage <: TextBearingSurface
    urn::Cite2Urn
    label::AbstractString
    rv::AbstractString
    image::Cite2Urn
    sequence::Int64
end


"""Override `show` for `MSPage`
$(SIGNATURES)
Required for `CitableTrait`.
"""
function show(io::IO, pg::MSPage)
    print(io, "<", pg.urn, "> ", pg.label)
end

"""Override `==` for `MSPage`
$(SIGNATURES)
"""
function ==(pg1::MSPage, pg2::MSPage)
    pg1.urn.urn == pg2.urn.urn && 
    pg1.label == pg2.label && 
    pg1.sequence == pg2.sequence && 
    pg1.rv == pg2.rv && 
    pg1.image == pg2.image
end




"Define singleton type to use as value of `CitableTrait` on `MSPage`."
struct PageCitable <: CitableTrait end
"""Set value of `CitableTrait` for `MSPage`.
$(SIGNATURES)
"""
function citabletrait(::Type{MSPage})
    PageCitable()
end

"""Type of URN identifying an `MSPage`.
$(SIGNATURES)
Required function for `Citable` abstraction.
"""
function urntype(::Type{MSPage})
    Cite2Urn
end


"""URN identifying `img`.
$(SIGNATURES)
Required function for `Citable` abstraction.
"""
function urn(pg::MSPage)
    pg.urn
end

"""Label for `pg`.
$(SIGNATURES)
Required function for `Citable` abstraction.
"""
function label(pg::MSPage)
    pg.label
end


# Example CEX record:
# 5|urn:cite2:hmt:msA.v1:3r|recto|Venetus A (Marciana 454 = 822), folio 3, recto|urn:cite2:hmt:vaimg.2017a:VA003RN_0004