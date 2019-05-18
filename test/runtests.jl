using Test

using RDD

@testset "define AbstractRDD interface" begin
    @testset "partitions function is defined" begin
        @test length(methods(partitions).ms) ≥ 0
    end
    @testset "preferredlocations function is defined" begin
        @test length(methods(preferredlocations).ms) ≥ 0
    end
    @testset "dependencies function is defined" begin
        @test length(methods(dependencies).ms) ≥ 0
    end
    @testset "iterator function is defined" begin
        @test length(methods(iterator).ms) ≥ 0
    end
    @testset "partitioner function is defined" begin
        @test length(methods(partitioner).ms) ≥ 0
    end
end
