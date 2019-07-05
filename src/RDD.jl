module RDD

include("./AbstractRDD.jl")
include("./ParallelCollectionRDD.jl")
include("./MapPartitionsRDD.jl")
include("./Transformations.jl")
include("./Actions.jl")
include("./Scheduler.jl")

using Lazy

using .AbstractRDDModule, 
      .ParallelCollectionRDDModule,
      .MapPartitionsRDDModule,
      .Transformations,
      .Actions,
      .Scheduler

export AbstractRDD,
    AbstractDependency,
    NarrowDependency,
    WideDependency,
    OneToOneDependency,
    ShuffleDependency,
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
    dependencies,
    build_dag,
    @as

end # module
