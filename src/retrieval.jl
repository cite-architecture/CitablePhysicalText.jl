
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
function surfacesfortext(txt::CtsUrn, dse::DSECollection; keepsubref = true)
    triplelist = filter(trip -> urncontains(txt, passage(trip)), dse.data)
    matched = keepsubref ? map(trip ->  surface(trip), triplelist) : map(trip ->  CitableText.dropsubref(surface(trip)), triplelist) 
    unique(u -> string(u), matched)
end

"""Find surfaces for text passage(s) identified by URN.
$(SIGNATURES)
"""
function imagesfortext(txt::CtsUrn, dse::DSECollection; keepsubref = true, keepversion = true)
    #triplelist = filter(trip -> urncontains(txt, passage(trip)), dse.data
    #matched = keepsubref ? map(trip ->  image(trip), triplelist) : map(trip ->  dropsubref(passage(trip)), triplelist)
    #unique(u -> string(u), matched)
    @info("Txt $(txt)")
    txturn = keepversion ? txt : dropversion(txt)
    @info("Look for txturn $(txturn)")
    triplelist = filter(dse.data) do tripl
        if keepversion
            urncontains(txturn, passage(tripl))
        else
            urncontains(txturn, dropversion(passage(tripl)))
        end
    end
    matched = keepsubref ? map(trip ->  image(trip), triplelist) : map(trip ->  dropsubref(passage(trip)), triplelist)
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

"""Find unique values for surface field of a collection.
$(SIGNATURES)
"""
function surfaces(dse::DSECollection)
    surfs = map(trip -> surface(trip), dse.data)
    unique(u -> string(u), surfs)
end


"""Find unique values for image field of a collection.
$(SIGNATURES)
"""
function images(dse::DSECollection; keepsubref = true)
    imgs = keepsubref ? map(trip -> image(trip), dse.data) :  map(trip -> CitableObject.dropsubref(image(trip)), dse.data)
    unique(u -> string(u), imgs)
end



"""Find unique values for passage field of a collection.
$(SIGNATURES)
"""
function passages(dse::DSECollection; keeppassage = true)
    psgs = keeppassage ? map(trip -> passage(trip), dse.data) :  map(trip -> droppassage(passage(trip)), dse.data)
    unique(u -> string(u), psgs)
end