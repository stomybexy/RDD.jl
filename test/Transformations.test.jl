using Test

@testset "RDD Transformations" begin

    @testset "map transformation" begin
        v = collect(1:1:10)
        parentrdd = ParallelCollectionRDD{Int}(v, 3)

        @testset "create a MapPartitionRDD{Any}" begin
            @test isa(map(x -> x * x, parentrdd), MapPartitionsRDD{Any})
        end

    end

end