# Use this from root directory of repository, e.g.,
# julia --project=docs/ docs/make.jl

using Pkg
Pkg.activate(".")
Pkg.instantiate()


using Documenter, DocStringExtensions, CitablePhysicalText

makedocs(
    sitename = "CitableText Documentation",
    pages = [
        "Home" => "index.md"       
    ]
    )

deploydocs(
    repo = "github.com/cite-architecture/CitablePhysicalText.jl.git",
) 
