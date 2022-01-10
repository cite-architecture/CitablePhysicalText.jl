```@setup proclus
root = pwd() |> dirname |> dirname
```

# Searching `DSECollection`s


The `CitablePhysicalText` package includes functions for querying a `DSECollection`.  We'll load a sample dataset from the file `test/assets/proclusdse.cex` in this github repository.

```@example proclus
using CitableBase
using CitablePhysicalText
f = joinpath(root, "test", "assets", "proclusdse.cex")
dsecoll = fromcex(f, DSECollection, FileReader)
```

You can find the unique list of URNs for each field of the collection's triples.

```@example proclus
surfaces(dsecoll)
```


The contents of `DSECollection`s can be queried with the following functions:


- `textsforsurface`
- `textsforimage`
- `surfacesfortext`
- `surfacesforimage`
- `imagesfortext`
- `imagesforsurface`


You can 
See the API documentation for details.