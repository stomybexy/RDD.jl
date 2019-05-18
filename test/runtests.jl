using Test

using RDD

@testset "Should greet" begin
    RDD.greet()
    @test 1 == 1
end
