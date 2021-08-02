

"""Create an array of `DseTriple`s from an array of Strings of delimited text.  The strings should represent, in this order:

1. the text passage
2. the image (possibly with region of interest)
3. the surface

$(SIGNATURES)
"""
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
