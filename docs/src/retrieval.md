```@setup proclus
root = pwd() |> dirname |> dirname
```

# Searching `DSECollection`s


## Finding unique values for each field of a `DSETriple`

The `CitablePhysicalText` package includes functions for querying a `DSECollection`.  We'll load a sample dataset from the file `test/assets/proclusdse.cex` in this github repository.

```@example proclus
using CitableBase
using CitablePhysicalText
f = joinpath(root, "test", "assets", "proclusdse.cex")
dsecoll = fromcex(f, DSECollection, FileReader)
```

You can find the unique list of URNs for each field of the collection's triples with the functions `surfaces`, `images` and `texts`.

```@example proclus
surfaces(dsecoll)
```

The `images` function has an optional parameter defining whether or not to include subreferences.
```@example proclus
images(dsecoll, keepsubref = false)
```



Similarly, the `passages` function has an optional parameter defining whether or not to include the passage component.
```@example proclus
passages(dsecoll, keeppassage = false)
```


## Querying by field

The following functions find values for one field of a `DSETriple` filtered by another field.


Find all text passages on a given surface:

```@example proclus
using CitableObject
page = Cite2Urn("urn:cite2:hmt:msA.v1:1r")
textsforsurface(page, dsecoll)
```


Find all text passages indexed to a given image:

```@example proclus
img = Cite2Urn("urn:cite2:hmt:vaimg.2017a:VA001RN_0002")
textsforimage(img, dsecoll)
```

Find what pages a text occurs on:
```@example proclus
using CitableText
homer = CtsUrn("urn:cts:greekLit:tlg4036.tlg023.va:Homer")
surfacesfortext(homer, dsecoll)
```

Find what images illustrate a text:
```@example proclus
homer = CtsUrn("urn:cts:greekLit:tlg4036.tlg023.va:Homer")
imagesfortext(homer, dsecoll)
```

In this example collection, only one reference image is used per surface. We can see that one-to-one mapping here.


```@example proclus
surfacesforimage(img, dsecoll)
```

```@example proclus
imagesforsurface(page, dsecoll)
```

