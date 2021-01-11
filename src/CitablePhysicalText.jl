module CitablePhysicalText

using CitableText, CitableObject
using Documenter, DocStringExtensions
using DataFrames

export DSETriple
export fromcex

include("dfs.jl")


"Citable relations of text passage, text-bearing surface and documentary image."
struct DSETriple
    passage::CtsUrn
    image::Cite2Urn
    surface::Cite2Urn
end

# text, image, surface
function fromcex(s::AbstractString, delimiter::AbstractString = "#")
    try 
        pieces = split(s, delimiter)
        if (size(pieces,1) != 3)
            throw(ArgumentError("Invalid input $(s). String must have 3 delimited components."))
        else
            begin
                psg = CtsUrn(pieces[1])
                img = Cite2Urn(pieces[2])
                surface = Cite2Urn(pieces[3])
                DSETriple(psg, img, surface)         
            end
        end
    catch  e
        throw(e)
    end
end


end # module
