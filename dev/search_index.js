var documenterSearchIndex = {"docs":
[{"location":"#RDD.jl-1","page":"Home","title":"RDD.jl","text":"","category":"section"},{"location":"lib/abstract_rdd/#","page":"AbstractRDD","title":"AbstractRDD","text":"Author = \"Jonatan Sombié\"\nCurrentModule = RDD ","category":"page"},{"location":"lib/abstract_rdd/#AbstractRDD-1","page":"AbstractRDD","title":"AbstractRDD","text":"","category":"section"},{"location":"lib/abstract_rdd/#","page":"AbstractRDD","title":"AbstractRDD","text":"Modules = [AbstractRDDModule]","category":"page"},{"location":"lib/abstract_rdd/#","page":"AbstractRDD","title":"AbstractRDD","text":"Modules = [AbstractRDDModule]","category":"page"},{"location":"lib/abstract_rdd/#RDD.AbstractRDDModule.AbstractDependency","page":"AbstractRDD","title":"RDD.AbstractRDDModule.AbstractDependency","text":"Parent type of rdd dependencies.\n\n\n\n\n\n","category":"type"},{"location":"lib/abstract_rdd/#RDD.AbstractRDDModule.AbstractPartitioner","page":"AbstractRDD","title":"RDD.AbstractRDDModule.AbstractPartitioner","text":"Parent type of rdd partitioner.\n\n\n\n\n\n","category":"type"},{"location":"lib/abstract_rdd/#RDD.AbstractRDDModule.AbstractRDD","page":"AbstractRDD","title":"RDD.AbstractRDDModule.AbstractRDD","text":"Parent type of rdds.\n\n\n\n\n\n","category":"type"},{"location":"lib/abstract_rdd/#RDD.AbstractRDDModule.dependencies-Tuple{AbstractRDD}","page":"AbstractRDD","title":"RDD.AbstractRDDModule.dependencies","text":"dependencies(rdd::AbstractRDD)::AbstractVector{AbstractDependency}\n\nReturns the list of parent rdds with a specification of the way this rdd depends on each one.\n\n\n\n\n\n","category":"method"},{"location":"lib/abstract_rdd/#RDD.AbstractRDDModule.iterator-Union{Tuple{T}, Tuple{AbstractRDD{T},Int64,AbstractArray{T,1} where T}} where T","page":"AbstractRDD","title":"RDD.AbstractRDDModule.iterator","text":"iterator(\n    rdd::AbstractRDD{T}, \n    partition::Int,\n    parentiters::AbstractVector\n)::AbstractPartitionIterator{T} where {T}\n\nReturns an iterator on a partition of the rdd given parent partition(s) iterators. This method must be implemented by subclasses of AbstractRDD.\n\n\n\n\n\n","category":"method"},{"location":"lib/abstract_rdd/#RDD.AbstractRDDModule.partitioner-Tuple{AbstractRDD}","page":"AbstractRDD","title":"RDD.AbstractRDDModule.partitioner","text":"partitioner(rdd::AbstractRDD)::Union{AbstractPartitioner, Nothing}\n\nReturns the partitioner of this rdd. Default implementation returns nothing.\n\n\n\n\n\n","category":"method"},{"location":"lib/abstract_rdd/#RDD.AbstractRDDModule.partitions-Union{Tuple{AbstractRDD{T}}, Tuple{T}} where T","page":"AbstractRDD","title":"RDD.AbstractRDDModule.partitions","text":"partitions(rdd::AbstractRDD{T})::Int64 where {T}\n\nReturns the number of partitions of the given rdd. This method must be implemented by subclasses of AbstractRDD. The default implementation raises an error.\n\n\n\n\n\n","category":"method"},{"location":"lib/abstract_rdd/#RDD.AbstractRDDModule.preferredlocations-Union{Tuple{T}, Tuple{AbstractRDD{T},Int64}} where T","page":"AbstractRDD","title":"RDD.AbstractRDDModule.preferredlocations","text":"preferredlocations(\n    rdd::AbstractRDD{T}, partition::Int\n)::AbstractVector{AbstractLocation} where {T}\n\nReturns the list of preffered locations ordered by preference for a partition of an rdd. The default implementation returns no preffered locations.\n\n\n\n\n\n","category":"method"},{"location":"lib/abstract_rdd/#RDD.AbstractRDDModule.AbstractLocation","page":"AbstractRDD","title":"RDD.AbstractRDDModule.AbstractLocation","text":"Parent type of rdd partitions preferred locations.\n\n\n\n\n\n","category":"type"},{"location":"lib/parallel_collection_rdd/#","page":"ParallelCollectionRDD","title":"ParallelCollectionRDD","text":"Author = \"Jonatan Sombié\"\nCurrentModule = RDD ","category":"page"},{"location":"lib/parallel_collection_rdd/#ParallelCollectionRDD-1","page":"ParallelCollectionRDD","title":"ParallelCollectionRDD","text":"","category":"section"},{"location":"lib/parallel_collection_rdd/#","page":"ParallelCollectionRDD","title":"ParallelCollectionRDD","text":"Modules = [ParallelCollectionRDDModule]","category":"page"},{"location":"lib/parallel_collection_rdd/#","page":"ParallelCollectionRDD","title":"ParallelCollectionRDD","text":"Modules = [ParallelCollectionRDDModule]","category":"page"},{"location":"lib/parallel_collection_rdd/#RDD.ParallelCollectionRDDModule.ParallelCollectionPartitionIterator","page":"ParallelCollectionRDD","title":"RDD.ParallelCollectionRDDModule.ParallelCollectionPartitionIterator","text":"struct ParallelCollectionPartitionIterator{T} <: AbstractPartitionIterator{T}\n\nType of the iterator of a ParallelCollectionPartition\n\n\n\n\n\n","category":"type"},{"location":"lib/parallel_collection_rdd/#RDD.ParallelCollectionRDDModule.ParallelCollectionRDD","page":"ParallelCollectionRDD","title":"RDD.ParallelCollectionRDDModule.ParallelCollectionRDD","text":"struct ParallelCollectionRDD{T} <: AbstractRDD{T}\n\nA subclass of AbstractRDD representing distributed in-memory collection.\n\n\n\n\n\n","category":"type"},{"location":"lib/parallel_collection_rdd/#RDD.ParallelCollectionRDDModule.ParallelCollectionRDD-Union{Tuple{AbstractArray{T,1}}, Tuple{T}} where T","page":"ParallelCollectionRDD","title":"RDD.ParallelCollectionRDDModule.ParallelCollectionRDD","text":"ParallelCollectionRDD{T}(col::AbstractVector{T}) where {T}\n\nCreate a ParallelCollectionRDD from a vector. The number of partitions will be the number of workers of a julia cluster as returned by workers(). If there is less than 2 workers, 2 partitions will be created.\n\n\n\n\n\n","category":"method"},{"location":"lib/parallel_collection_rdd/#RDD.ParallelCollectionRDDModule.ParallelCollectionRDD-Union{Tuple{T}, Tuple{AbstractArray{T,1},Int64}} where T","page":"ParallelCollectionRDD","title":"RDD.ParallelCollectionRDDModule.ParallelCollectionRDD","text":"ParallelCollectionRDD{T}(col::AbstractVector{T}, numpart::Int) where {T}\n\nCreate a ParallelCollectionRDD from a vector with numpart partitions.\n\n\n\n\n\n","category":"method"},{"location":"lib/parallel_collection_rdd/#RDD.ParallelCollectionRDDModule.ParallelCollectionPartition","page":"ParallelCollectionRDD","title":"RDD.ParallelCollectionRDDModule.ParallelCollectionPartition","text":"struct ParallelCollectionPartition{T} <: AbstractPartition{T}\n\nType of a partition of ParallelCollectionRDD\n\n\n\n\n\n","category":"type"},{"location":"lib/parallel_collection_rdd/#RDD.AbstractRDDModule.iterator-Union{Tuple{T}, Tuple{ParallelCollectionRDD{T},Int64}, Tuple{ParallelCollectionRDD{T},Int64,AbstractArray{T,1} where T}} where T","page":"ParallelCollectionRDD","title":"RDD.AbstractRDDModule.iterator","text":"iterator(\n    rdd::ParallelCollectionRDD{T}, \n    numpart::Int,\n    parentiters::AbstractVector{AbstractPartitionIterator} = AbstractPartitionIterator[]\n)::ParallelCollectionPartitionIterator{T} where {T}\n\nImplementation of iterator for ParallelCollectionRDD.\n\n\n\n\n\n","category":"method"},{"location":"lib/parallel_collection_rdd/#RDD.AbstractRDDModule.partitions-Union{Tuple{ParallelCollectionRDD{T}}, Tuple{T}} where T","page":"ParallelCollectionRDD","title":"RDD.AbstractRDDModule.partitions","text":"partitions(\n        rdd:: ParallelCollectionRDD{T}\n    )::Int64 where {T}\n\nImplementation of partitions for ParallelCollectionRDD.\n\n\n\n\n\n","category":"method"},{"location":"lib/mappartitionsrdd/#","page":"MapPartitionsRDD","title":"MapPartitionsRDD","text":"Author = \"Jonatan Sombié\"\nCurrentModule = RDD ","category":"page"},{"location":"lib/mappartitionsrdd/#MapPartitionsRDD-1","page":"MapPartitionsRDD","title":"MapPartitionsRDD","text":"","category":"section"},{"location":"lib/mappartitionsrdd/#","page":"MapPartitionsRDD","title":"MapPartitionsRDD","text":"Modules = [MapPartitionsRDDModule]","category":"page"},{"location":"lib/mappartitionsrdd/#","page":"MapPartitionsRDD","title":"MapPartitionsRDD","text":"Modules = [MapPartitionsRDDModule]","category":"page"},{"location":"lib/mappartitionsrdd/#RDD.MapPartitionsRDDModule.MapPartitionsRDD","page":"MapPartitionsRDD","title":"RDD.MapPartitionsRDDModule.MapPartitionsRDD","text":"struct MapPartitionsRDD{T} <: AbstractRDD{T}\n\nType of an rdd whose partitions are derived from a parent rdd partitions by application of a map function.\n\n\n\n\n\n","category":"type"},{"location":"lib/mappartitionsrdd/#RDD.AbstractRDDModule.iterator-Tuple{MapPartitionsRDD,Int64,AbstractArray{T,1} where T}","page":"MapPartitionsRDD","title":"RDD.AbstractRDDModule.iterator","text":"iterator(rdd::MapPartitionsRDD, part::Int, parentiters::AbstractVector)\n\nImplementation of iterator for MapPartitionsRDD. Returns the elements of parent partition transformed by map function.\n\n\n\n\n\n","category":"method"},{"location":"lib/mappartitionsrdd/#RDD.AbstractRDDModule.partitions-Tuple{MapPartitionsRDD}","page":"MapPartitionsRDD","title":"RDD.AbstractRDDModule.partitions","text":"partitions(rdd::MapPartitionsRDD)::Int64\n\nImplementation of partitions for MapPartitionsRDD. Returns the same partitions count as parent rdd.\n\n\n\n\n\n","category":"method"},{"location":"lib/transformations/#","page":"Transformations","title":"Transformations","text":"Author = \"Jonatan Sombié\"\nCurrentModule = RDD ","category":"page"},{"location":"lib/transformations/#RDD-Transformations-1","page":"Transformations","title":"RDD Transformations","text":"","category":"section"},{"location":"lib/transformations/#","page":"Transformations","title":"Transformations","text":"Modules = [Transformations]","category":"page"},{"location":"lib/transformations/#","page":"Transformations","title":"Transformations","text":"Modules = [Transformations]","category":"page"},{"location":"lib/transformations/#RDD.Transformations.flatmap","page":"Transformations","title":"RDD.Transformations.flatmap","text":"flatmap(f, rdd::AbstractRDD, type::Type = Any)::AbstractRDD{type}\n\nGiven a rdd and a function f that returns an iterator, returns a rdd whose elements are those  coming from all the iterators f(x) for x in parent rdd.\n\n\n\n\n\n","category":"function"},{"location":"lib/transformations/#Base.filter-Union{Tuple{T}, Tuple{Any,AbstractRDD{T}}} where T","page":"Transformations","title":"Base.filter","text":"filter(f, rdd::AbstractRDD{T})::AbstractRDD{T} where {T}\n\nReturns a filtered rdd from rdd with the given filter function f.\n\n\n\n\n\n","category":"method"},{"location":"lib/transformations/#Base.map","page":"Transformations","title":"Base.map","text":"map(f, rdd::AbstractRDD, type::Type = Any)::AbstractRDD{type}\n\nGenerates a new rdd by transforming elements of rdd with function f. type should be the returned type of map function f.\n\n\n\n\n\n","category":"function"}]
}