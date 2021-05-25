# Run this from repository root, e.g. with
# 
#    julia --project=docs/ docs/make.jl
#
using Pkg
Pkg.activate(".")
Pkg.instantiate()


using Documenter, DocStringExtensions, CitablePhysicalText

makedocs(sitename = "CitablePhysicalText Documentation")
