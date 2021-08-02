
"""Create a DataFrame from an array of Strings.
The array should be a Vector of 3-unit vectors with strings representing URNs for, in this order:

1. the text passage
2. the image (possibly with region of interest)
3. the surface

$(SIGNATURES)
"""
function vecvectodf(arr)
    passages = map(row -> CtsUrn(row[1]), arr)
	images = map(row -> Cite2Urn(row[2]), arr)
	surfaces = map(row -> Cite2Urn(row[3]), arr)
    DataFrame(passage = passages, image = images, surface = surfaces)
end

"""Create a DataFrame from a Vector of `DseTriple`s.

$(SIGNATURES)
"""
function df(triples)
    passages = map(triple -> triple.passage, triples)
    images = map(triple -> triple.image, triples)
    surfaces = map(triple -> triple.surface, triples)
    DataFrame(passage = passages, image = images, surface = surfaces)
end

"""Create a Vector of `DseTriple`s from a file.


$(SIGNATURES)
"""
function fromfile(f)
    "TBA"
end

