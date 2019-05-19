using Test

using RDD

@testset "RDD tests" begin
    include("./AbstractRDD.test.jl")
    include("./ParallelCollectionRDD.test.jl")
end
