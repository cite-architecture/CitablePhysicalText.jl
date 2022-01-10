
"""Find text passages on surface `surf`
$(SIGNATURES)
"""
function textsforsurface(surf::Cite2Urn, dse::DSECollection)
    triplelist = filter(trip -> urncontains(surf, surface(trip)), dse.data)
    map(trip ->  passage(trip), triplelist)
end


"""Find surfaces for text passage(s) identified by URN.
$(SIGNATURES)
"""
function surfacesfortext(txt::CtsUrn, dse::DSECollection)
    triplelist = filter(trip -> urncontains(txt, passage(trip)), dse.data)
    matched = map(trip ->  surface(trip), triplelist) 
    unique(u -> string(u), matched)
end

"""Find surfaces for text passage(s) identified by URN.
$(SIGNATURES)
"""
function imagesfortext(txt::CtsUrn, dse::DSECollection; dropsubref = false)
    triplelist = filter(trip -> urncontains(txt, passage(trip)), dse.data)
    matched = map(trip ->  image(trip), triplelist) 
    unique(u -> string(u), matched)
end



"""Find surfaces for text passage(s) identified by URN.
$(SIGNATURES)
"""
function imagesforsurface(surf::Cite2Urn, dse::DSECollection; keepsubref = true)
    triplelist = filter(trip -> urncontains(surf, surface(trip)), dse.data)
    matched = keepsubref ? map(trip ->  image(trip), triplelist)  :   map(trip ->  CitableObject.dropsubref(image(trip)), triplelist) 
    unique(u -> string(u), matched)
end


"""Find surfaces for image(s) identified by URN.
$(SIGNATURES)
"""
function surfacesforimage(img::Cite2Urn, dse::DSECollection; keepsubref = true)
    triplelist = filter(trip -> urncontains(img, CitableObject.dropsubref(image(trip))), dse.data)
    matched = keepsubref ? map(trip ->  surface(trip), triplelist)  :   map(trip ->  CitableObject.dropsubref(image(trip)), triplelist) 
    unique(u -> string(u), matched)
end




"""Find text passages for image(s) identified by URN.
$(SIGNATURES)
"""
function textsforimage(img::Cite2Urn, dse::DSECollection; keepsubref = true)
    triplelist = filter(trip -> urncontains(img, CitableObject.dropsubref(image(trip))), dse.data)
    #matched = keepsubref ? map(trip ->  passage(trip), triplelist)  :   map(trip ->  CitableObject.dropsubref(image(trip)), triplelist) 
    matched = map(trip ->  passage(trip), triplelist)
    unique(u -> string(u), matched)
end