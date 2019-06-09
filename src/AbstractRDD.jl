
module AbstractRDDModule

using DocStringExtensions

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

""" $(SIGNATURES)
"""
abstract type AbstractRDD{T} end

""" $(SIGNATURES)
"""
abstract type AbstractPartition{T} end

""" $(SIGNATURES)
"""
abstract type AbstractPartitionIterator{T} end

""" $(SIGNATURES)
"""
abstract type AbstractLocation end

""" $(SIGNATURES)
"""
abstract type AbstractDependency end

""" $(SIGNATURES)
"""
abstract type AbstractPartitioner end

""" 
    partitions(rdd::AbstractRDD{T})::AbstractVector{AbstractPartition{T}} where {T} 

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

""" $(SIGNATURES)
"""
function dependencies(rdd::AbstractRDD)::AbstractVector{AbstractDependency} 
    error("method dependencies(::$(typeof(rdd))) has not bean implemented")
end

""" $(SIGNATURES)
"""
function iterator(
        rdd::AbstractRDD{T},
        partition::Int, 
        parent_iters::AbstractVector{AbstractPartitionIterator}) :: AbstractPartitionIterator{T} where {T}

    error("method iterator(::$(typeof(rdd)),::$(typeof(partition)),::$(typeof(parent_iters))) has not bean implemented")

end

""" $(SIGNATURES)
"""
function partitioner(rdd::AbstractRDD)::AbstractPartitioner 
    error("method partitioner(::$(typeof(rdd))) has not bean implemented")
end

end
