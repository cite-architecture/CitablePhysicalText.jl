

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


"""Override `==` for `DSECollection`
$(SIGNATURES)
"""
function ==(dse1::DSECollection, dse2::DSECollection)
    dse1.urn.urn == dse2.urn.urn && dse1.label == dse2.label && dse1.data == dse2.data
end


"Define singleton type to use as value of `CitableTrait` on `DSECollection`."
struct CitableDSETriple <: CitableTrait end

"""Set value of `CitableTrait` for `DSECollection`.
$(SIGNATURES)
"""
function citabletrait(::Type{DSECollection})
    CitableDSETriple()
end

"""URN identifying `dsec`.
$(SIGNATURES)
Required function for `Citable` abstraction.
"""
function urn(dsec::DSECollection)
    dsec.urn
end


"""Label for `dsec`.
$(SIGNATURES)
Required function for `Citable` abstraction.
"""
function label(dsec::DSECollection)
    dsec.label
end

"Define singleton type to use as value of `UrnComparisonTrait` on `DSECollection`."
struct ComparableDSECollection <: UrnComparisonTrait end
"""Set value of `UrnComparisonTrait` for `DSECollection`.
$(SIGNATURES)
"""
function urncomparisontrait(::Type{DSECollection})
    ComparableDSECollection()
end

"""True if  collections' urns match for equality.
$(SIGNATURES)
"""
function urnequals(dse1::DSECollection, dse2::DSECollection)
    dse1.urn == dse2.urn
end

"""True if  collections' urns match for containment.
$(SIGNATURES)
"""
function urncontains(dse1::DSECollection, dse2::DSECollection)
    urncontains(dse1.urn, dse2.urn)
end

"""True if  collections' urns match for similarity.
$(SIGNATURES)
"""
function urnsimilar(dse1::DSECollection, dse2::DSECollection)
    urnsimilar(dse1.urn, dse2.urn)
end

"Define singleton type to use as value of `CexTrait` on `DSECollection`."
struct DSECex <: CexTrait end
"""Set value of `UrnComparisonTrait` for `DSECollection`.
$(SIGNATURES)
"""
function cextrait(::Type{DSECollection})
    DSECex()
end

"""Format a `DSECollection` as a delimited-text string.
$(SIGNATURES)
Required function for `Citable` abstraction.
"""
function cex(dsec::DSECollection; delimiter = "|")
    lines = ["#!citerelationset",
        "urn$(delimiter)$(urn(dsec))",
        "label$(delimiter)$(label(dsec))",
        "passage$(delimiter)imageroi$(delimiter)surface"
    ]
    for dsetriple in dsec.data
        push!(lines, delimited(dsetriple, delimiter = delimiter))
    end
    join(lines, "\n")
end

"""Parse a delimited-text string into a `DSECollection`.
$(SIGNATURES)
`cexsrc` should be a single `citerelationset` block.
"""
function fromcex(trait::DSECex, cexsrc::AbstractString, ::Type{DSECollection}; 
    delimiter = "|", configuration = nothing, strict = true)
    (coll_urn, coll_label) = headerinfo(cexsrc, delimiter = delimiter)
    triplelist = triples(join(data(cexsrc, "citerelationset", delimiter = delimiter), "\n"))
    DSECollection(coll_urn, coll_label, triplelist)
end


"""Parse header of `cexsrc` into URN and label for DSE collection.
$(SIGNATURES)
`cexsrc` should be a single `citerelationset` block.
"""
function headerinfo(cexsrc::AbstractString; delimiter = "|")
    cexblock = blocks(cexsrc, "citerelationset")[1]
    urnkv = split(cexblock.lines[1], delimiter)
    labelkv = split(cexblock.lines[2], delimiter)
    (Cite2Urn(urnkv[2]), labelkv[2])
end