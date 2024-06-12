"A single page (one side of a folio) of a codex"
struct MSPage <: TextBearingSurface
    urn::Cite2Urn
    label::AbstractString
    rv::AbstractString
    image::Cite2Urn
    sequence::Integer
end

"""Find recto or verso value for page.
$(SIGNATURES)
"""
function rectoverso(pg::MSPage)
    pg.rv
end

"""Find image illustrating page.
$(SIGNATURES)
"""
function image(pg::MSPage)::Cite2Urn
    pg.image
end


"""Find sequence of page within a codex.
$(SIGNATURES)
"""
function sequence(pg::MSPage)
    pg.sequence
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


"Define singleton type to use as value of `UrnComparisonTrait` on `MSPage`."
struct PageComparable <: UrnComparisonTrait end
"""Set value of `UrnComparisonTrait` for `MSPage`.
$(SIGNATURES)
"""
function urncomparisontrait(::Type{MSPage})
    PageComparable()
end

"""Implement urn comparison for equality for `MSPage`.
$(SIGNATURES)
"""
function urnequals(u::Cite2Urn, pg1::MSPage)
    pg1.urn == u
end

"""Implement urn comparison for containment for `MSPage`.
$(SIGNATURES)
"""
function urncontains(u::Cite2Urn, pg1::MSPage)
    urncontains(u, pg1.urn)
end
"""Implement urn comparison for similarity for `MSPage`.
$(SIGNATURES)
"""
function urnsimilar(u::Cite2Urn, pg1::MSPage)
    urnsimilar(u, pg1.urn)
end

"Define singleton type to use as value of `CexTrait` on `MSPage`."
struct PageCex <: CexTrait end
import CitableBase: cextrait
"""Set value of `CexTrait` for `MSPage`.
$(SIGNATURES)
"""
function cextrait(::Type{MSPage})
    PageCex()
end

"""Serialie `pg` to delimited text.
$(SIGNATURES)
Required for `CexTrait`.
"""    
function cex(pg::MSPage; delimiter = "|")
    join([string(pg.urn), pg.label, pg.rv, string(pg.image), pg.sequence], delimiter)
end


"""Instantiate a `MSPage`from delimited text.
$(SIGNATURES)
"""
function fromcex(traitvalue::PageCex, cexsrc::AbstractString, T;
    delimiter = "|", configuration = nothing, strict = true)
    fields = split(cexsrc, delimiter)
    urn = Cite2Urn(fields[1])
    lbl = fields[2]
    rv = fields[3]
    img = Cite2Urn(fields[4])
    seq = parse(Int64, fields[5])
    MSPage(urn, lbl, rv, img, seq)
end


# Example CEX record:
# 5|urn:cite2:hmt:msA.v1:3r|recto|Venetus A (Marciana 454 = 822), folio 3, recto|urn:cite2:hmt:vaimg.2017a:VA003RN_0004