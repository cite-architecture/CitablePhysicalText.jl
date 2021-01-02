using Pkg
pkg"activate .."
push!(LOAD_PATH,"../src/")
using Documenter, DocStringExtensions, CitablePhysicalText

makedocs(sitename = "CitablePhysicalText Documentation")
