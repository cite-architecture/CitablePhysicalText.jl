![build](https://github.com/cite-architecture/CitablePhysicalText.jl/actions/workflows/Documentation.yml/badge.svg)


# CitablePhysicalText.jl

A julia module for working with digital scholarly editions following the DSE model associating:

- a citable passage of text
- a citable physical surface (such as a page of a manuscript, or face of an inscribed stone)
- a citable documentary image illustrating the passage


## Roadmap to 1.0

- [x] 0.4.x Fully implement abstraction of citable object from `CitableBase`
- [x] 0.5.x Implement basic suite of queries on DSE model
- [ ] 0.6.x Use `CitableImage` to create visualizations of `DSERecord`