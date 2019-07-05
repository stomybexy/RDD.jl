using Test

using RDD, Distributed
import RDD

@testset "RDD tests" begin
    include("./AbstractRDD.test.jl")
    include("./ParallelCollectionRDD.test.jl")
    include("./MapPartitionsRDD.test.jl")
    include("./Transformations.test.jl")
    include("./Actions.test.jl")
    include("./Scheduler.test.jl")
end
