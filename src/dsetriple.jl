
"Citable relations of text passage, text-bearing surface and documentary image."
struct DSETriple
    passage::CtsUrn
    image::Cite2Urn
    surface::Cite2Urn
end


"""Override `==` for `DSETriple`
$(SIGNATURES)
"""
function ==(dse1::DSETriple, dse2::DSETriple)
    dse1.passage.urn == dse2.passage.urn && dse1.image.urn == dse2.image.urn && dse1.surface.urn == dse2.surface.urn
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


"""Compose a Vector of `DSETriple`s from delimited-text source.
$(SIGNATURES)
"""
function triples(src::AbstractString; delimiter = "|")
   triplelist = DSETriple[]   
   lines = split(src, "\n")
   nonempty = filter(ln -> ! isempty(ln), lines)
   for ln in nonempty
    push!(triplelist, triple(ln, delimiter = delimiter))
   end
   triplelist
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

"""Format `trip` as delimited text.
$(SIGNATURES)
"""
function delimited(trip::DSETriple; delimiter = "|")
    join(
        [trip.passage.urn, trip.image.urn, trip.surface.urn],
        delimiter
    )
end