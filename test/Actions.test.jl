using Test

@testset "RDD Actions" begin

    @testset "reduce action" begin
        @testset "should work with a simple function" begin
            rdd = ParallelCollectionRDD{Int}(1:1:10)
            @test reduce(+, rdd, 0) == 55
        end
        @testset "should work with a custom function" begin
            f(x, y) = x*y
            rdd = ParallelCollectionRDD{Int}(1:1:4)
            @test reduce(f, rdd, 1) == 24
        end
    end

end
