using Test

@testset "RDD Scheduler" begin

    @testset "build_dag function" begin
        @testset "should build one stage dag with orphan rdd" begin
            rdd = ParallelCollectionRDD{Int}(1:10)
            dag = build_dag(rdd)
            @test isempty(dag.parent)
        end
        @testset "should build one stage dag with narrow dependencies" begin
            rdd = @as _x_ ParallelCollectionRDD{Int}(1:10) map(i -> 2i, _x_)
            dag = build_dag(rdd)
            @test isempty(dag.parent)
        end
        @testset "should build multiple stages dag with wide dependencies" begin
            struct FakeRDD{T} <: AbstractRDD{T}
                parent::AbstractRDD
            end
            RDD.dependencies(d::FakeRDD) = [ShuffleDependency(d.parent)]
            rdd = @as _x_ ParallelCollectionRDD{Int}(1:10) map(i -> 2i, _x_) FakeRDD{Any}(_x_)
            dag = build_dag(rdd)
            @test length(dag.parent) == 1
            @test isempty(dag.parent[1].parent)
        end
       
    end

end