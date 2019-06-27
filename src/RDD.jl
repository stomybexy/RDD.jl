module RDD

include("./AbstractRDD.jl")
include("./ParallelCollectionRDD.jl")
include("./MapPartitionsRDD.jl")
include("./Transformations.jl")
include("./Actions.jl")

using Lazy

using .AbstractRDDModule, 
      .ParallelCollectionRDDModule,
      .MapPartitionsRDDModule,
      .Transformations,
      .Actions

export AbstractRDD,
    Dependency,
    AbstractPartitioner,
    partitions,
    preferredlocations,
    dependencies,
    iterator,
    partitioner,
    ParallelCollectionRDD,
    MapPartitionsRDD,
    flatmap,
    compute,
    @as

end # module
