

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

"""URN type for a `DSECollection`.
$(SIGNATURES)
Required function for `Citable` abstraction.
"""
function urntype(dsec::DSECollection)
    Cite2Urn
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
    modelcex(dsec, delimiter = delimiter) * "\n\n" * join(lines, "\n")
end

function modelcex(dsec::DSECollection; delimiter = "|")
    lines = [
    "#!datamodels",
    join(["Collection", "Model", "Label", "Description"], delimiter),
    join([string(urn(dsec)), "urn:cite2:cite:datamodels.v1:dsemodel",  
    "Passage of text in a digital scholarly edition",
    "Relations of text, manuscript page and documentary image for all edited texts"])
    ]
    join(lines, "\n")
end




"""Parse a delimited-text string into a `DSECollection`.
$(SIGNATURES)
`cexsrc` should be a single `citerelationset` block.
"""
function fromcex(trait::DSECex, 
    cexsrc::AbstractString, 
    ::Type{DSECollection}; 
    delimiter = "|", configuration = nothing, strict = true)
    if strict == false
        @warn("Lazily treating all relation set data as one DSECollection")
        datalines = data(cexsrc, "citerelationset")
        if isempty(datalines)
            throw(DomainError("No citerelationset block found in source CEX."))
        end

        tripleset = map(line -> triple(line, delimiter = delimiter), datalines)
        label = "Automatically assembled set of DSETriples"
        cols = split(datalines[1], delimiter)
        relseturn = Cite2Urn(cols[2]) |> dropobject
        [DSECollection(relseturn, label, tripleset)]

    else
        impls = implementations(cexsrc, CitablePhysicalText.DSE_MODEL)
        if isempty(impls)
            throw(DomainError("No citerelationsets configured for DSE model $(CitablePhysicalText.DSE_MODEL)."))
        end

        relsets = DSECollection[]
        for impl in impls
            label = relationsetlabel(cexsrc, impl)
            tripleset = map(line -> triple(line, delimiter = delimiter), relations(cexsrc, impl))

            push!(relsets, DSECollection(impl, label, tripleset))
        end
        relsets
    end
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
