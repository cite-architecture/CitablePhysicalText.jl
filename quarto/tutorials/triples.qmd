# The `DSETriple`

Construct a `DSETriple` from a triple of URN values.

```@example triple
using CitablePhysicalText
using CitableBase, CitableObject, CitableText

psg = CtsUrn("urn:cts:trmilli:tl.25.v1:1")
img = Cite2Urn("urn:cite2:lycian:hc.v1:2007.02.0003@0.04848,0.09494,0.7129,0.07528")
surf = Cite2Urn("urn:cite2:trmilli:inscriptions.v1:TL25")
triple = DSETriple(psg, img, surf)
```    

Use these functions to extract particular fields.

```@example triple
passage(triple)
```
```@example triple
image(triple)
```
```@example triple
surface(triple)
```


!!! note "A note on URN comparison"

    Note that since each component of the triple is a URN, you can test it with URN logic, as the following example illustrates.


```@example triple
tl25 = CtsUrn("urn:cts:trmilli:tl.25.v1:")
urncontains(tl25, passage(triple))
```