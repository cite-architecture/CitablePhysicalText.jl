module CitablePhysicalText

using Documenter, DocStringExtensions

import Base: ==
import Base: show

using Base.Iterators
import Base: length
import Base: eltype
import Base: iterate
import Base: filter
import Base: reverse

import CitableBase: citablecollectiontrait

using CitableBase
import CitableBase: citabletrait
import CitableBase: urn
import CitableBase: label
import CitableBase: urntype

import CitableBase: urncomparisontrait
import CitableBase: urnequals
import CitableBase: urncontains
import CitableBase: urnsimilar

import CitableBase: cextrait
import CitableBase: cex
import CitableBase: fromcex

using CitableText, CitableObject
using CiteEXchange


export DSETriple
export triple, triples 
export passage, image, surface

export DSECollection
export passages, images, surfaces
export textsforsurface, textsforimage
export surfacesfortext, surfacesforimage
export imagesfortext, imagesforsurface

export MSPage
export Codex, codex

"Abstract type for physical objects with text"
abstract type TextBearingSurface end


include("constants.jl")
include("dsetriple.jl")
include("dsecollection.jl")
include("retrieval.jl")
include("mspage.jl")
include("codex.jl")

end # module
