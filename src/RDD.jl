module RDD

include("./AbstractRDD.jl")
include("./ParallelCollectionRDD.jl")
include("./MapPartitionsRDD.jl")
include("./Transformations.jl")

using .AbstractRDDModule, 
      .ParallelCollectionRDDModule,
      .MapPartitionsRDDModule,
      .Transformations

export AbstractRDD,
    AbstractDependency,
    AbstractPartitioner,
    partitions,
    preferredlocations,
    dependencies,
    iterator,
    partitioner,
    ParallelCollectionRDD,
    ParallelCollectionPartitionIterator,
    MapPartitionsRDD,
    flatmap

end # module
