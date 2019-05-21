using Test

using RDD, Distributed

@testset "RDD tests" begin
    include("./AbstractRDD.test.jl")
    include("./ParallelCollectionRDD.test.jl")
end
