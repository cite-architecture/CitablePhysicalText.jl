

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