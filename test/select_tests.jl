using Pkg
Pkg.activate("..")


using CitablePhysicalText
using CitableBase
using CitableObject
using CitableText


using Test
using TestSetExtensions



@testset "All the tests" begin
    println(map(s -> replace(s, r".jl$" => ""), ARGS))
    @includetests map(s -> replace(s, r".jl$" => ""), ARGS)
end