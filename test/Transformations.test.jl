using Test

@testset "RDD Transformations" begin

    @testset "map transformation" begin
        v = collect(1:1:15)
        parentrdd = ParallelCollectionRDD{Int}(v, 3)

        @testset "creates a rdd of type Any" begin
            @test isa(map(x -> x * x, parentrdd), AbstractRDD{Any})
        end

        @testset "creates a rdd of type Int" begin
            @test isa(map(x -> x * x, parentrdd, Int), AbstractRDD{Int})
        end

        @testset "applies map function to each element of parent rdd" begin
            rdd = map(x -> x * x, parentrdd, Int)
            parentiter = iterator(parentrdd, 1)
            @test collect(iterator(rdd, 1, AbstractPartitionIterator[parentiter])) == [1, 4, 9, 16, 25]
        end

    end

    @testset "filter transformation" begin
        v = collect(1:1:10)
        parentrdd = ParallelCollectionRDD{Int}(v, 2)

        @testset "should keep the type of parent rdd" begin
            @test isa(filter(x -> x % 2 == 0, parentrdd), AbstractRDD{Int})
        end
        @testset "should correctly filter parent rdd elements" begin
            rdd = filter(x -> x % 2 == 0, parentrdd)
            parentiter = iterator(parentrdd, 1)
            @test collect(iterator(rdd, 1, AbstractPartitionIterator[parentiter])) == [2,4]
        end
    end

end