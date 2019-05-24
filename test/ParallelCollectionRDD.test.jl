using Test

function rmworkers() 
    for worker in workers()
        rmprocs(worker)
    end
end

v = Int[1,2,3,4,5,6]

@testset "ParallelCollectionRDD" begin

    @testset "define partitions interface" begin
        rdd = ParallelCollectionRDD{Int}(ParallelCollectionPartition{Int}[], Symbol("blabla"))
        @test isa(partitions(rdd), AbstractVector{ParallelCollectionPartition{Int}})
    end

    @testset "Constructor" begin
        
        @testset "can be constructed from an Vector" begin
            rdd = ParallelCollectionRDD{Int}(v)
            @test isa(rdd, ParallelCollectionRDD{Int})
        end
        @testset "number of partitions can be specified"  begin
            rdd = ParallelCollectionRDD{Int}(v, 2)
            @test partitions(rdd) |> length == 2
        end
        @testset "use by default as much partitions as workers" begin
            addprocs(3)
            rdd = ParallelCollectionRDD{Int}(v)
            @test partitions(rdd) |> length == 3
        end
        @testset "do not use less than 2 partitions" begin
            rmworkers()
            @test workers() |> length == 1
            rdd = ParallelCollectionRDD{Int}(v)
            @test partitions(rdd) |> length == 2
        end
    end

    @testset "iterator implementation" begin
        @testset "should be defined" begin
            rdd = ParallelCollectionRDD{Int}(v)
            @test isa(iterator(rdd, 1, AbstractPartitionIterator[]), ParallelCollectionPartitionIterator{Int})
        end
        @testset "should return partition data with the default partitioner (range)" begin
            rdd = ParallelCollectionRDD{Int}(v, 2)
            iter = iterator(rdd, 1, AbstractPartitionIterator[])
            @test  collect(iter) == [1,2,3]
        end
    end
   
end


