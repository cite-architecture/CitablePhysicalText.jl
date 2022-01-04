
"Citable relations of text passage, text-bearing surface and documentary image."
struct DSETriple
    passage::CtsUrn
    image::Cite2Urn
    surface::Cite2Urn
end

"""Compose a `DSETriple` from delimited-text source.
$(SIGNATURES)
"""
function triple(src::AbstractString; delimiter = "|")
    parts = split(src, delimiter)
    DSETriple(
        CtsUrn(parts[1]),
        Cite2Urn(parts[2]),
        Cite2Urn(parts[3])
    )
end


"""Return `passage` field of `trip`.
$(SIGNATURES)
"""
function passage(trip::DSETriple)
    trip.passage
end

"""Return `image` field of `trip`.
$(SIGNATURES)
"""
function image(trip::DSETriple)
    trip.image
end


"""Return `surface` field of `trip`.
$(SIGNATURES)
"""
function surface(trip::DSETriple)
    trip.surface
end