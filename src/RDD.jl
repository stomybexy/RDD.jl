module RDD

include("./AbstractRDD.jl")
include("./ParallelCollectionRDD.jl")
include("./MapPartitionsRDD.jl")
include("./Transformations.jl")
include("./Actions.jl")

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
    ParallelCollectionPartitionIterator,
    MapPartitionsRDD,
    flatmap,
    compute

end # module
