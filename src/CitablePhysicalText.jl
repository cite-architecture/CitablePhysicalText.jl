module CitablePhysicalText

using Documenter, DocStringExtensions
using Downloads

using SplitApplyCombine

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
using CitableObject.CexUtils
using CiteEXchange

using CitableImage

using JSON

export DSETriple
export triple, triples 
export passage, image, surface

export DSECollection
export passages, images, surfaces
export textsforsurface, textsforimage
export surfacesfortext, surfacesforimage
export imagesfortext, imagesforsurface

export MSPage, sequence, image, rectoverso
export Codex, codex

export IIIFConfig, iiifmanifest, iiifconfig


"Abstract type for physical objects with text"
abstract type TextBearingSurface end


include("constants.jl")
include("dsetriple.jl")
include("dsecollection.jl")
include("retrieval.jl")
include("mspage.jl")
include("codex.jl")
include("iiif.jl")


end # module
