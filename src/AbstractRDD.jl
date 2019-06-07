
module AbstractRDDModule

using Documenter, DocStringExtensions

export AbstractRDD,
    AbstractPartition,
    AbstractDependency,
    AbstractPartitioner,
    AbstractPartitionIterator,
    partitions,
    preferredlocations,
    dependencies,
    iterator,
    partitioner

abstract type AbstractRDD{T} end
abstract type AbstractPartition{T} end
abstract type AbstractPartitionIterator{T} end
abstract type AbstractLocation end
abstract type AbstractDependency end
abstract type AbstractPartitioner end

""" $(SIGNATURES)
Returns the list of partitions of the given rdd.
"""
function partitions(rdd::AbstractRDD{T})::AbstractVector{AbstractPartition{T}} where {T} 
    error("method partitions(::$(typeof(rdd))) has not bean implemented")
end

""" $(SIGNATURES)
Returns the list of preffered locations ordered by preference for a partition of an rdd.
"""
function preferredlocations(
            rdd::AbstractRDD{T}, 
            partition::Int
        )::AbstractVector{AbstractLocation} where {T} 

    error("method preferredlocations(::$(typeof(rdd)), ::$(typeof(partition))) has not bean implemented")

end

function dependencies(rdd::AbstractRDD)::AbstractVector{AbstractDependency} 
    error("method dependencies(::$(typeof(rdd))) has not bean implemented")
end

function iterator(
        rdd::AbstractRDD{T},
        partition::Int, 
        parent_iters::AbstractVector{AbstractPartitionIterator}) :: AbstractPartitionIterator{T} where {T}

    error("method iterator(::$(typeof(rdd)),::$(typeof(partition)),::$(typeof(parent_iters))) has not bean implemented")

end

function partitioner(rdd::AbstractRDD)::AbstractPartitioner 
    error("method partitioner(::$(typeof(rdd))) has not bean implemented")
end

end
