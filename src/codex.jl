"A codex is a collection of manuscript pages."
struct Codex
    pages::Vector{MSPage}
end

"""Override `Base.==` for `Codex`.
$(SIGNATURES)
"""
function ==(c1::Codex, c2::Codex)
    c1.pages == c2.pages
end


"""Override `Base.show` for `Codex`.
$(SIGNATURES)
"""
function show(io::IO, codex::Codex)
    pagecount = length(codex.pages)
    if pagecount == 1
        print(io, "Codex with 1 page")
    else
        print(io, "Codex with ", pagecount, " pages")
    end
end


"""Define singleton type to use as value for `CitableCollectionTrait`."""
struct CitableCodex <: CitableCollectionTrait end
"""Define value of `CitableCollectionTrait` for `Codex`.
$(SIGNATURES)
"""
function citablecollectiontrait(::Type{Codex})
    CitableCodex()
end

"""Define singleton type to use as value for `UrnComparisonTrait`."""
struct CodexComparable <: UrnComparisonTrait end
"""Define value of `UrnComparisonTrait` for `Codex`.
$(SIGNATURES)
"""
function urncomparisontrait(::Type{Codex})
    CodexComparable()
end

"""Implement URN comparison for equality on `codex`.
$(SIGNATURES)
"""
function urnequals(u::Cite2Urn, codex::Codex )
    filter(pg -> urnequals(u, pg.urn), codex.pages)
end


"""Implement URN comparison for containment on `codex`.
$(SIGNATURES)
"""
function urncontains(u::Cite2Urn, codex::Codex)
    filter(pg -> urncontains(u, pg.urn), codex.pages)
end

"""Implement URN comparison for similarity on `codex`.
$(SIGNATURES)
"""
function urnsimilar(u::Cite2Urn, codex::Codex)
    filter(pg -> urnsimilar(u, pg.urn), codex.pages)
end
