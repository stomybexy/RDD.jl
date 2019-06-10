using Test

using RDD, Distributed

@testset "RDD tests" begin
    include("./AbstractRDD.test.jl")
    include("./ParallelCollectionRDD.test.jl")
    include("./MapPartitionsRDD.test.jl")
    include("./Transformations.test.jl")
end
