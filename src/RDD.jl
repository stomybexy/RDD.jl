module RDD

include("./AbstractRDD.jl")
include("./ParallelCollectionRDD.jl")

using .AbstractRDDModule, .ParallelCollectionRDDModule

export AbstractRDD,
    AbstractPartition,
    AbstractDependency,
    AbstractPartitioner,
    AbstractPartitionIterator,
    partitions,
    preferredlocations,
    dependencies,
    iterator,
    partitioner,
    ParallelCollectionRDD,
    ParallelCollectionPartition,
    ParallelCollectionPartitionIterator

end # module
