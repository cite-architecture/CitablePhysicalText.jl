# The `CitablePhysicalText` module


## Overview

The `CitablePhysicalText` module works with texts in the context of a physical surface — a manuscript page, surface of an inscription, or column of a papyrus, for example —  that is illustrated by documentary images.   Its fundamental data structure associates triplets of text, surface and image, and since this model is essential for a diplomatic scholarly edition is named the `DSETriple`.

In a `DSETriple`, a passage of text, a surface and an image (or region of an image) are each citable scholarly resources: the text is identified by CtsUrn; the surface and image are identified by Cite2Urn.

The module includes functions to read delimited text into a Vector of `DseTriple`s, and to convert a Vector of `DseTriple`s to a DataFrame.
