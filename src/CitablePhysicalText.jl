module CitablePhysicalText

using CitableBase



using CitableText, CitableObject
using CiteEXchange
using Documenter, DocStringExtensions
using DataFrames, CSV


export DSETriple


#export fromcex, df, vecvectodf

include("dsetriple.jl")
include("dsecollection.jl")
#include("cex.jl")
#include("dfs.jl")



end # module
