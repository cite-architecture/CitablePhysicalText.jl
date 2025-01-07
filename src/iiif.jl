"""Information needed to compose a IIIF Presentation Manifest.
"""
struct IIIFConfig
    manifest_id
    canvas_id_base
    page_id_base
    annotation_id_base
    image_extension
    labels_lang
end


"""Derive an IIIF identifier from an image URN and an IIIF service.
$(SIGNATURES)
"""
function iiif_image_id(imgurn::Cite2Urn, svc::IIIFservice)
    string(svc.baseurl,"?IIIF=",svc.directoryroot, "/", CitableImage.subdirectory(imgurn), "/", objectcomponent(dropsubref(imgurn)))
end

"""Read an IIIF info request (`info.json`)  from a given IIIF service for the image illustrating a codex page.
$(SIGNATURES)
"""
function imageinfo(pg::MSPage, svc::IIIFservice)
    imageinfo(pg.image, svc)
end

"""Read an IIIF info request (`info.json`) for an image URN on a given IIIF service.
$(SIGNATURES)
"""
function imageinfo(imgurn::Cite2Urn, svc::IIIFservice; extension = "tif")
    infourl = string(svc.baseurl,"?IIIF=",svc.directoryroot, "/", CitableImage.subdirectory(imgurn), "/", objectcomponent(dropsubref(imgurn)), ".$(extension)/info.json")
     f = Downloads.download(infourl)
     jsoninfo = read(f, String)
     rm(f)
     jsoninfo
end

"""Compose the IIIF manifest entry for a single page of a codex. In IIIF, this is represented by a Canvas, containing an AnnotationPage, in turn containing an Annotation to paint the Canvas.
$(SIGNATURES)
"""
function pagemanifest(pg::MSPage, conf::IIIFConfig, svc::IIIFservice; srcextension = "tif")

    pgid =  objectcomponent(pg.urn)
    imgid = iiif_image_id(pg.image, svc)
    pginfo = imageinfo(pg.image, svc) |> JSON.parse
    h = pginfo["height"]
    w = pginfo["width"]

    jsontext = """{
        "id": "$(conf.canvas_id_base)$(pgid)",
        "type": "Canvas",
        "label": {
            "$(conf.labels_lang)": [
                "$(label(pg))"
            ]
        },
        "height": $(h),
        "width": $(w),
     
        "items": [
            {
                "id": "$(conf.annotation_id_base)$(pgid)",
                "type": "AnnotationPage",
                "items": [
                    {
                    "id": "$(conf.annotation_id_base)$(pgid)",
                    "type": "Annotation",
                    "motivation": "painting",
                    "body": {
                        "id": "$(url(pg.image, svc))",
                        "type": "Image",
                        "format": "image/jpeg",
                        "height": $(h),
                        "width": $(w)
                    },
                    "target": "$(conf.canvas_id_base)$(pgid)",
                    "service": [
                        {
                            "id": "$(imgid).$(srcextension)",
                            "profile": "level1",
                            "type": "ImageService2"
                        }
                    ]
                    }
                ]
            }
            ]
        }
    """
    jsontext
end



"""Compose a complete IIIF presentation manifest for a codex collection.
$(SIGNATURES)
"""
function iiifmanifest(c::Codex, conf::IIIFConfig, svc::IIIFservice)
    lbl = label(c)


    jsonlines = [
    "{" ,
    "\"@context\": \"http://iiif.io/api/presentation/3/context.json\",",
    "\"id\": \"$(conf.manifest_id)\",", 
    "\"type\": \"Manifest\",",

    "\"label\": {",
    "\"$(conf.labels_lang)\": [",
            "\"$(lbl)\"",
    "]",
    "},",
    "\"items\": ["
     
    ]

    pagelist = []
    for pg in c.pages
        push!(pagelist, pagemanifest(pg, conf,svc))
    end

    push!(jsonlines, join(pagelist, ", "))
        

    # Close items:
    push!(jsonlines, "]")
    # Close structure:
    push!(jsonlines, "}")
    # Return a string:
    join(jsonlines," ")
end

