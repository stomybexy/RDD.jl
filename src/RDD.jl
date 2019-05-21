module RDD

using Distributed, Random

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

include("./AbstractRDD.jl")
include("./ParallelCollectionRDD.jl")

end # module
