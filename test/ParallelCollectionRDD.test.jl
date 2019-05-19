
@testset "ParallelCollectionRDD tests" begin

    @testset "define partitions interface" begin
        rdd = ParallelCollectionRDD{Int}()
        @test isa(partitions(rdd), AbstractVector{ParallelCollectionPartition{Int}})
    end

end