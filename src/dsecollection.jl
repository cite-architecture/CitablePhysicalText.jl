

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


struct ComparableDSECollection <: UrnComparisonTrait end

function urncomparisontrait(::Type{DSECollection})
    ComparableDSECollection()
end


function urnequals(dse1::DSECollection, dse2::DSECollection)
    dse1.urn == dse2.urn
end
function urncontains(dse1::DSECollection, dse2::DSECollection)
    urncontains(dse1.urn, dse2.urn)
end
function urnsimilar(dse1::DSECollection, dse2::DSECollection)
    urnsimilar(dse1.urn, dse2.urn)
end


struct DSECex <: CexTrait end
function cextrait(::Type{DSECollection})
    DSECex()
end

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

function fromcex(cexsrc::AbstractString, ::Type{DSECollection}; 
    delimiter = "|", configuration = nothing)
    (coll_urn, coll_label) = headerinfo(cexsrc, delimiter = delimiter)
    triplelist = triples(join(data(cexsrc, "citerelationset", delimiter = delimiter), "\n"))
    DSECollection(coll_urn, coll_label, triplelist)
end

function headerinfo(cexsrc::AbstractString; delimiter = "|")
    cexblock = blocks(cexsrc, "citerelationset")[1]
    urnkv = split(cexblock.lines[1], delimiter)
    labelkv = split(cexblock.lines[2], delimiter)
    (Cite2Urn(urnkv[2]), labelkv[2])
end