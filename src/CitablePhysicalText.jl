module CitablePhysicalText

import Base: ==
import Base: show

using CitableBase
import CitableBase: citabletrait
import CitableBase: urn
import CitableBase: label

import CitableBase: urncomparisontrait
import CitableBase: urnequals
import CitableBase: urncontains
import CitableBase: urnsimilar

import CitableBase: cextrait
import CitableBase: cex
import CitableBase: fromcex

using CitableText, CitableObject
using CiteEXchange

using Documenter, DocStringExtensions
using DataFrames, CSV

export DSETriple
export triple, triples 
export passage, image, surface

export DSECollection
export passages, images, surfaces
export textsforsurface, textsforimage
export surfacesfortext, surfacesforimage
export imagesfortext, imagesforsurface

include("dsetriple.jl")
include("dsecollection.jl")
include("retrieval.jl")


#include("cex.jl")
#include("dfs.jl")



end # module
