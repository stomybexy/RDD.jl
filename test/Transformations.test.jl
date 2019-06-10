using Test

@testset "RDD Transformations" begin

    @testset "map transformation" begin
        v = collect(1:1:10)
        parentrdd = ParallelCollectionRDD{Int}(v, 3)

        @testset "create a MapPartitionRDD{Any}" begin
            @test isa(map(x -> x * x, parentrdd), MapPartitionsRDD{Any})
        end

        @testset "create a MapPartitionRDD{Int}" begin
            @test isa(map(x -> x * x, parentrdd, Int), MapPartitionsRDD{Int})
        end

    end

end