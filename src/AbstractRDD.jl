
abstract type AbstractRDD{T} end
abstract type AbstractPartition{T} end
abstract type AbstractLocation end
abstract type AbstractDependency end
abstract type AbstractPartitionIterator{T} end
abstract type AbstractPartitioner end

function partitions(rdd::AbstractRDD{T})::AbstractArray{AbstractPartition{T}} where {T} end

function preferredlocations(
        rdd::AbstractRDD{T}, partition::AbstractPartition{T}
    )::AbstractArray{AbstractLocation} where {T} end

function dependencies(rdd::AbstractRDD)::AbstractArray{AbstractDependency} end

function iterator(
        rdd::AbstractRDD{T}, partition::AbstractPartition{T}, parent_iters::AbstractArray{AbstractPartitionIterator}
    )::AbstractPartitionIterator{T} where {T} end

function partitioner(rdd::AbstractRDD)::AbstractPartitioner end
