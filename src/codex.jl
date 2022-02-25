
"A codex is a collection of manuscript pages."
struct Codex
    description::AbstractString
    pages::Vector{MSPage}
end

"""Convenience function for creating `Codex` objects.
$(SIGNATURES)
"""
function codex(pages::Vector{MSPage}; description = "")
    if isempty(pages)
        throw(DomainError("Cannot create a `Codex` with no pages."))
    end
    label = ""
    if isempty(description)
        if length(pages) == 1
            label = "Codex with 1 page"
        else
            label = "Codex with $(length(pages)) pages"
        end
    else
        label = description
    end
    Codex(label, pages)
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
    write(io, codex.description)
end


"Define singleton type for use with `CitableTrait`"
struct CitableByPage <: CitableTrait end
"""Define value of `CitableTrait` for `Codex`
$(SIGNATURES)
"""
function citabletrait(::Type{Codex})
    CitableByPage()
end

"""Codex pages are citable by `Cite2Urn`.
$(SIGNATURES)
"""
function urntype(ms::Codex)
    Cite2Urn
end

"""Find collection-level URN for collection.
$(SIGNATURES)
"""
function urn(ms::Codex)
    dropobject(ms.pages[1].urn)
end

"""Find collection-level URN for collection.
$(SIGNATURES)
"""
function label(ms::Codex)
    ms.description
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

"""Define singleton type to use as value for `CitableCollectionTrait`."""
struct CodexCex <: CexTrait end
"""Define value of `CexTrait` for `Codex`.
$(SIGNATURES)
"""
function cextrait(::Type{Codex})
    CodexCex()
end

"""Serialize `ms` to delimited text in CEX format.
$(SIGNATURES)

"""
function cex(ms::Codex; delimiter = "|")
    datalines = ["#!citedata",
    join(["urn", "label", "rv", "image", "sequence"], delimiter)    
    ]
    for pg in ms.pages
        push!(datalines, cex(pg, delimiter = delimiter))
    end

    dmcex(ms, delimiter = delimiter)  * "\n\n" * propertiescex(ms::Codex, delimiter = delimiter) * "\n\n" * join(datalines, "\n")
end

"""Compose `datamodel` CEX block for `ms`.
$(SIGNATURES)
"""
function dmcex(ms::Codex; delimiter = "|")
    lines = [
        "#!datamodels",
        "Collection|Model|Label|Description",
        join([string(urn(ms)), string(CODEX_MODEL), label(ms)], delimiter)      
    ]
    join(lines, "\n")
end

"""Compose `citeproperties` CEX block for `ms`.
$(SIGNATURES)
"""
function propertiescex(ms::Codex; delimiter = "|")
    urnsettings = join([
        string(addproperty(urn(ms), "urn")),
        "URN",
        "Cite2Urn",
        ""
    ], delimiter)

    labelsettings = join([
        string(addproperty(urn(ms), "label")),
        "Label",
        "String",
        ""
    ], delimiter)

    rvsettings = join([
        string(addproperty(urn(ms), "rv")),
        "Recto or verso",
        "String",
        "recto,verso"
    ], delimiter)

    imgsettings = join([
        string(addproperty(urn(ms), "image")),
        "TBS image",
        "Cite2Urn",
        ""
    ], delimiter)

    seqsettings = join([
        string(addproperty(urn(ms), "sequence")),
        "Page seqence",
        "Number",
        ""
    ], delimiter)
    lines = ["#!citeproperties",
        "Property|Label|Type|Authority list",
        urnsettings,
        labelsettings,
        rvsettings,
        imgsettings,
        seqsettings
    ]  
    join(lines, "\n")
end

"""Instantiate a Vector of `Codex` objects from `cexsrc`.
$(SIGNATURES)
"""
function fromcex(trait::CodexCex, cexsrc::AbstractString, T;
    delimiter = "|", configuration = nothing, strict = true)
    if strict == false
        @warn("Lazily treating all cite collection data as one Codex")
        datalines = data(cexsrc, "citedata")


    else
        impls = implementations(cexsrc, CitablePhysicalText.CODEX_MODEL) 
        if isempty(impls)
            throw(DomainError("No cite data collections configured for codex model $(CitablePhysicalText.CODEX_MODEL)."))
        end

        codices = Codex[]
        for impl in impls
            blk = collectionblock(cexsrc, impl)
            headerdict = columnindex(blk)
            mspages = []
            for ln in blk.lines[2:end]
                push!(mspages, mspagefromdelimited(ln, headerdict, delimiter = delimiter))
            end
            label = cataloglabel(cexsrc, impl)
            push!(codices, Codex(label, mspages))
        end
        codices
    end

end

"""Use an index of column headers to parse a line of delimited text into a `MSPage`.
$(SIGNATURES)
"""
function mspagefromdelimited(ln::AbstractString, orderdict; delimiter = "|")
    strs = split(ln, delimiter)
    pgurn = strs[orderdict["urn"]] |> Cite2Urn
    pglabel = strs[orderdict["urn"]]
    pgrv = strs[orderdict["rv"]]
    pgimg = strs[orderdict["image"]] |> Cite2Urn
    pgseq = parse(Int64, strs[orderdict["sequence"]])

    MSPage(pgurn, pglabel, pgrv, pgimg, pgseq)
end



"""Create instances of `Codex` from `cexsrc` by consulting the
`datamodels` blocks of the CEX data and filtering content 
of `citedata` blocks for matching collections.
$(SIGNATURES)
"""
function parsedatamodel(cexsrc::AbstractString; delimiter = "|")
    dms = data(cexsrc, "datamodels")
    @debug("DMs in CEX", length(dms))
    codexcollections = Cite2Urn[]
    for dm in dms
        cols = split(dm, delimiter)
        if Cite2Urn(cols[2]) == CODEX_MODEL
            push!(codexcollections, Cite2Urn(cols[1]))
        end
    end

    datablocks = blocks(cexsrc, "citedata")
    codices = Codex[]
    for db in datablocks
        try
            refurn = Cite2Urn(urnpeek(db)) |> dropobject
            if refurn in codexcollections
                @debug("Woot! save block with URN ", refurn)
                onecodex = parsecodexblock(db)
                @debug("Parsing yielded", onecodex)
                push!(codices, parsecodexblock(db))
            end
            
        catch
            # Collection in configured list
        end
    end
    codices

end


"""Map column labels to column numbers
$(SIGNATURES)
"""
function columndict(b::Block; delimiter = "|")
    hdr = b.lines[1]
    cols = split(hdr, delimiter)
    orderdict = Dict()
    for i in 1:length(cols)
        orderdict[lowercase(cols[i])] = i
    end
    orderdict
end


function parsecodexblock(cexsrc::AbstractString; delimiter = "|")
    parsecodexblock(blocks(cexsrc, "citedata")[1], delimiter = delimiter)
end

"""Instantiate a `Codex` from data in a single `citedata` block.
$(SIGNATURES)
Read the header line for the block to determine ordering of required columns.
"""
function parsecodexblock(b::Block; delimiter = "|")
    @debug("Parse single block")
    orderdict = columndict(b, delimiter = delimiter)
    datalines = b.lines[2:end]
    pagelist  = MSPage[]
    @debug("Parse", length(datalines))
    for ln in datalines    
        strs = split(ln, "|")
        pgurn = strs[orderdict["urn"]] |> Cite2Urn
        pglabel = strs[orderdict["urn"]]
        pgrv = strs[orderdict["rv"]]
        pgimg = strs[orderdict["image"]] |> Cite2Urn
        pgseq = parse(Int64, strs[orderdict["sequence"]])

        push!(pagelist, MSPage(pgurn, pglabel, pgrv, pgimg, pgseq))
    end
    codex(pagelist)

end

function urnpeek(datablock::Block; delimiter = "|")
    urnindex = columndict(datablock)["urn"]
    cols = split(datablock.lines[2], delimiter)
    cols[urnindex]
end

"""Number of pages in `ms`.
$(SIGNATURES)
"""
function length(ms::Codex)
    length(ms.pages)
end


	
"""A `Codex` is a collection of `MSPage`s.
$(SIGNATURES)
"""
function eltype(ms::Codex)
    MSPage
end

"""Initial state of iterator for a `Codex`.
$(SIGNATURES)
"""
function iterate(ms::Codex)
    isempty(ms.pages) ? nothing : (ms.pages[1], 2)
end

"""Iterate a `Codex` with array index at `state`.
$(SIGNATURES)
"""
function iterate(ms::Codex, state)
    state > length(ms.pages) ? nothing : (ms.pages[state], state + 1)
end

"""Filter the list of pages in a `Codex`.
$(SIGNATURES)
"""
function filter(f, ms::Codex)
     Iterators.filter(f, collect(ms))
end

"""Reverse the order of pages in a `Codex`.
$(SIGNATURES)
I don't know, maybe you need to page through backwards
for some reason.
"""
function reverse(ms::Codex)
    reverse(ms.pages)
end
