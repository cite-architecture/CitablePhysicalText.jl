# The `CitablePhysicalText` module


## Overview

The `CitablePhysicalText` module works with texts in the context of a physical surface — a manuscript page, surface of an inscription, or column of a papyrus, for example —  that is illustrated by documentary images.   Its fundamental data structure, the `DSETriple`, associates triplets of text, surface and image, and since this model is essential for a diplomatic scholarly edition is named the `DSETriple`  Each component of the triple is a citable scholarly resources: the text is identified by `CtsUrn`; the surface and image are identified by `Cite2Urn`.

The `DSECollection` is a [*citable object*](https://cite-architecture.github.io/CitableBase.jl/stable/citable/) (as defined in `CitableBase`): it is identified by a URN, and has a human-readable label. It also has a list of `DSETriple`s, and functions for selecting triples using URN logic.
