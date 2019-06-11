using Test

@testset "MapPartitionsRDD" begin

    v = collect(1:1:10)

    @testset "defines the same number of partitions as parent rdd" begin
        parentrdd = ParallelCollectionRDD{Int}(v, 3)
        rdd = MapPartitionsRDD{Int}(x->x * x, parentrdd)
        @test partitions(rdd) == partitions(parentrdd)
    end

    @testset "Transform parent rdd element by map function" begin
        parentrdd = ParallelCollectionRDD{Int}(v, 2)
        rdd = MapPartitionsRDD{Int}(x->x * x, parentrdd)

        parentiter = iterator(parentrdd, 1)

        @test collect(iterator(rdd, 1, AbstractPartitionIterator[parentiter])) == [1, 4, 9, 16, 25]
    end 

end