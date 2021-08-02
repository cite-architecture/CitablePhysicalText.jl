# Build documentation (from the root directory of this repository):
#
#    julia --project=docs/ docs/make.jl
#
# Serve the docs locally  (from the root directory of this repository):
# 
#    julia -e 'using LiveServer; serve(dir="docs/build")'
#
using Pkg
Pkg.activate(".")
Pkg.instantiate()


using Documenter, DocStringExtensions, CitablePhysicalText

makedocs(
    sitename = "CitableText Documentation",
    pages = [
        "Home" => "index.md",
        "API documentation"   => "apis.md"
    ]
    )

deploydocs(
    repo = "github.com/cite-architecture/CitablePhysicalText.jl.git",
) 
