using Test

@testset "define AbstractRDD interface" begin

    struct TestRDD{T} <: AbstractRDD{T} end
    rdd = TestRDD{Int}()

    @testset "partitions interface must be defined" begin
        @test_throws ErrorException partitions(rdd)
    end
    @testset "No prefeered locations by default" begin
        @test isempty(preferredlocations(rdd, 1))
    end
    @testset "No dependencies by default" begin
        @test isempty(dependencies(rdd))
    end
    @testset "iterator function is defined" begin
        @test_throws ErrorException iterator(rdd, 1, AbstractPartitionIterator[])
    end
    @testset "partitioner function is defined" begin
        @test isnothing(partitioner(rdd))
    end
end
