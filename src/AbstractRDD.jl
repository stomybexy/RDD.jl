
abstract type AbstractRDD{T} end
abstract type AbstractPartition{T} end
abstract type AbstractLocation end
abstract type AbstractDependency end
abstract type AbstractPartitionIterator{T} end
abstract type AbstractPartitioner end

function partitions(rdd::AbstractRDD{T})::AbstractVector{AbstractPartition{T}} where {T} 
    error("method partitions(::$(typeof(rdd))) has not bean implemented")
end

function preferredlocations(
            rdd::AbstractRDD{T}, 
            partition::AbstractPartition{T}
        )::AbstractVector{AbstractLocation} where {T} 

    error("method preferredlocations(::$(typeof(rdd)), ::$(typeof(partition))) has not bean implemented")

end

function dependencies(rdd::AbstractRDD)::AbstractVector{AbstractDependency} 
    error("method dependencies(::$(typeof(rdd))) has not bean implemented")
end

function iterator(
        rdd::AbstractRDD{T}, 
        partition::AbstractPartition{T}, 
        parent_iters::AbstractVector{AbstractPartitionIterator}
    )::AbstractPartitionIterator{T} where {T} 

    error("method iterator(::$(typeof(rdd)),::$(typeof(partition)),::$(typeof(parent_iters))) has not bean implemented")

end

function partitioner(rdd::AbstractRDD)::AbstractPartitioner 
    error("method partitioner(::$(typeof(rdd))) has not bean implemented")
end
