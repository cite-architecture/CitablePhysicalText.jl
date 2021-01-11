#=
There's a `dse_df` function in MID `EditorsRepo`
that does this with an array:

	passages = map(row -> CtsUrn(row[1]), arr)
	images = map(row -> Cite2Urn(row[2]), arr)
	surfaces = map(row -> Cite2Urn(row[3]), arr)
    DataFrame(passage = passages, image = images, surface = surfaces)
    
=#

function df(triples)
    passages = map(triple -> triple.passage, triples)
    images = map(triple -> triple.image, triples)
    surfaces = map(triple -> triple.surface, triples)
    DataFrame(passage = passages, image = images, surface = surfaces)
end

