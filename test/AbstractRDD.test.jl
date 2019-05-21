
@testset "define AbstractRDD interface" begin

    struct TestRDD{T} <: AbstractRDD{T} end
    rdd = TestRDD{Int}()

    @testset "partitions interface must be defined" begin
        @test_throws ErrorException partitions(rdd)
    end
    @testset "preferredlocations function is defined" begin
        @test_throws ErrorException preferredlocations(rdd, 1)
    end
    @testset "dependencies function is defined" begin
        @test_throws ErrorException dependencies(rdd)   
    end
    @testset "iterator function is defined" begin
        @test_throws ErrorException iterator(rdd, 1, AbstractPartitionIterator[])
    end
    @testset "partitioner function is defined" begin
        @test_throws ErrorException partitioner(rdd)
    end
end
