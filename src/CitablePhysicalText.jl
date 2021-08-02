module CitablePhysicalText

using CitableText, CitableObject
using CiteEXchange
using Documenter, DocStringExtensions
using DataFrames, CSV


export DSETriple
export fromcex, df, vecvectodf

include("cex.jl")
include("dfs.jl")


"Citable relations of text passage, text-bearing surface and documentary image."
struct DSETriple
    passage::CtsUrn
    image::Cite2Urn
    surface::Cite2Urn
end


end # module
