struct IIIFConfig
    manifest_id
    canvas_id_base
    page_id_base
    annotation_id_base
    image_extension
    labels_lang
    
end
#=
Things we need:

1. an id like this: https://shot.holycross.edu/iiif/complutensian-bne/manifest.json

(ie, really it's a URL)

2. for each page, its dimensions.  How do we get that?  Maybe a parallel vector of dimensions?

3. URLs for canvas objects

4.  URLs for annotation page objects

5. a format for the image (MIME like image/jpeg)

6. an actual URL for the image in IIIF parlance  (ends "full/full/0/default.jpg")

{scheme}://{server}{/prefix}/{identifier}/info.json


Majnifest id: https://shot.holycross.edu/iiif/complutensian-bne/manifest.json

Canves ID base: http://shot.holycross.edu/complutensiancanvases/bne/v1/

Page ID base: http://shot.holycross.edu/complutensianpages/bne/v1

Annotation ID base: http://shot.holycross.edu/complutensianannotations/bne/vv1

Image base: https://www.homermultitext.org/iipsrv?IIIF=/project/homer/pyramidal/deepzoom


https://www.homermultitext.org/iipsrv?IIIF=/project/homer/pyramidal/deepzoom/citebne/complutensian/v1/v1p1.tif/info.json


https://www.homermultitext.org/iipsrv?IIIF=/project/homer/pyramidal/deepzoom/citebne/complutensian/v1/v1p1.tif/info.json

=#


#=
Support this:
{
  "@context" : "http://iiif.io/api/image/2/context.json",
  "@id" : "https://www.homermultitext.org/iipsrv?IIIF=/project/homer/pyramidal/deepzoom/citebne/complutensian/v1/v1p1.tif",
  "protocol" : "http://iiif.io/api/image",
  "width" : 2250,
  "height" : 1421,
  "sizes" : [
     { "width" : 140, "height" : 88 },
     { "width" : 281, "height" : 177 },
     { "width" : 562, "height" : 355 },
     { "width" : 1125, "height" : 710 }
  ],
  "tiles" : [
     { "width" : 256, "height" : 256, "scaleFactors" : [ 1, 2, 4, 8, 16 ] }
  ],
  "profile" : [
     "http://iiif.io/api/image/2/level1.json",
     { "formats" : [ "jpg" ],
       "qualities" : [ "native","color","gray" ],
       "supports" : ["regionByPct","sizeByForcedWh","sizeByWh","sizeAboveFull","rotationBy90s","mirroring","gray"] }
  ]
}

=#


function pagemanifest(pg, conf::IIIFConfig)
   x =  """{
        "id": "http://shot.holycross.edu/complutensiancanvases/bne/v1/img1",
        "type": "Canvas",
        "label": {
            "en": [
                "Volume 1, image 1"
            ]
        }
    """

    val = """{
        "id": "http://shot.holycross.edu/complutensiancanvases/bne/v1/img1"
        }"""
    val
end
# canvas: http://shot.holycross.edu/complutensiancanvases/bne/v1/img1
# page: 
# 
function iiifmanifest(c::Codex, conf::IIIFConfig)
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




    push!(jsonlines, pagemanifest(c.pages[1], conf))
        

    # Close items:
    push!(jsonlines, "]")
    # Close structure:
    push!(jsonlines, "}")
    
    join(jsonlines," ")
end

