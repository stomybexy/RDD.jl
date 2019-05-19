
@testset "define AbstractRDD interface" begin

    struct TestRDD{T} <: AbstractRDD{T} end
    struct TestPartition{T} <: AbstractPartition{T} end
    rdd = TestRDD{Int}()
    part = TestPartition{Int}()

    @testset "partitions interface must be defined" begin
        @test_throws ErrorException partitions(rdd)
    end
    @testset "preferredlocations function is defined" begin
        @test_throws ErrorException preferredlocations(rdd, part)
    end
    @testset "dependencies function is defined" begin
        @test_throws ErrorException dependencies(rdd)   
    end
    @testset "iterator function is defined" begin
        @test_throws ErrorException iterator(rdd, part, AbstractChannel[])
    end
    @testset "partitioner function is defined" begin
        @test_throws ErrorException partitioner(rdd)
    end
end
