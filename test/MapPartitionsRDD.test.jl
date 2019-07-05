using Test

@testset "MapPartitionsRDD" begin

    v = collect(1:1:10)

    @testset "defines the same number of partitions as parent rdd" begin
        parentrdd = ParallelCollectionRDD{Int}(v, 3)
        rdd = MapPartitionsRDD{Int}(iter -> iter, parentrdd)
        @test partitions(rdd) == partitions(parentrdd)
    end

    @testset "defines a oneToOne dependency to parent rdd" begin
        parentrdd = ParallelCollectionRDD{Int}(v)
        rdd = MapPartitionsRDD{Int}(iter -> iter, parentrdd)
        dep = dependencies(rdd)[1]
        @test dep isa OneToOneDependency
        @test dep.rdd == parentrdd
        
    end

end