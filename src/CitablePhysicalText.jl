module CitablePhysicalText

using CitableBase
import CitableBase: citabletrait
import CitableBase: urn
import CitableBase: label


import CitableBase: cexserializabletrait
import CitableBase: cex
import CitableBase: fromcex


import CitableBase: urncomparisontrait
import CitableBase: urnequals
import CitableBase: urncontains
import CitableBase: urnsimilar

using CitableText, CitableObject
using CiteEXchange
using Documenter, DocStringExtensions
using DataFrames, CSV


export DSETriple
export triple, triples 
export passage, image, surface


export DSECollection

#export fromcex, df, vecvectodf

include("dsetriple.jl")
include("dsecollection.jl")
#include("cex.jl")
#include("dfs.jl")



end # module
