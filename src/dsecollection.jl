

"""A citable object wrapping a set of `DSETriple`s.

$(SIGNATURES)
"""
struct DSECollection <: Citable
    urn::Cite2Urn
    label::AbstractString
    data::Vector{DSETriple}
end

"""Override `show` for `DSECollection`
$(SIGNATURES)
Required for `CitableTrait`.
"""
function show(io::IO, dses::DSECollection)
    print(io, dses.urn, " ", dses.label)
end


"Define singleton type to use as value of `CitableTrait` on `DSECollection`."
struct CitableDSETriple <: CitableTrait end

"""Set value of `CitableTrait` for `DSECollection`.
$(SIGNATURES)
"""
function citabletrait(::Type{DSECollection})
    CitableDSETriple()
end


function urn(dsec::DSECollection)
    dsec.urn
end


function label(dsec::DSECollection)
    dsec.label
end