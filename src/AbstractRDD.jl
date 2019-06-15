
module AbstractRDDModule

using DocStringExtensions

import Base: zero

export AbstractRDD,
    Dependency,
    AbstractPartitioner,
    partitions,
    preferredlocations,
    dependencies,
    iterator,
    partitioner,
    compute

"""
Parent type of rdds.
"""
abstract type AbstractRDD{T} end

"""
Type of rdd dependency. 
"""
struct Dependency
    rdd::AbstractRDD
    partitions::AbstractVector{Int}
    type::Symbol
end

"""
Parent type of rdd partitioner.
"""
abstract type AbstractPartitioner end

""" 
    partitions(rdd::AbstractRDD{T})::Int64 where {T} 

Returns the number of partitions of the given rdd.
This method must be implemented by subclasses of [`AbstractRDD`](@ref).
The default implementation raises an error.
"""
function partitions(rdd::AbstractRDD{T})::Int64 where {T} 
    error("method partitions(::$(typeof(rdd))) has not bean implemented")
end

""" 
    preferredlocations(
        rdd::AbstractRDD{T}, partition::Int
    )::AbstractVector{Int} where {T} 

Returns the list of workers where it is preferable to compute this `partition`.
The list is ordered by preference.
"""
function preferredlocations(
            rdd::AbstractRDD{T}, 
            partition::Int
        )::AbstractVector{Int} where {T} 
    []
end

""" 
    dependencies(rdd::AbstractRDD, partition::Int)::AbstractVector{Dependency}

Returns the list of parent rdds partitions `partition` of `rdd` depends on 
with the type of the dependency.
"""
function dependencies(rdd::AbstractRDD, partition::Int)::AbstractVector{Dependency} 
    []
end

""" 
    iterator(
        rdd::AbstractRDD{T}, 
        partition::Int,
        parentiters::AbstractVector
    )::AbstractPartitionIterator{T} where {T}

Returns an iterator on a partition of the rdd given parent partition(s) iterators.
This method must be implemented by subclasses of [`AbstractRDD`](@ref).
"""
function iterator(
        rdd::AbstractRDD{T},
        partition::Int, parentiters::AbstractVector) where {T}

    error("method iterator(::$(typeof(rdd)),::$(typeof(partition))) has not bean implemented")

end

"""
    partitioner(rdd::AbstractRDD)::Union{AbstractPartitioner, Nothing} 

Returns the partitioner of this rdd.
Default implementation returns nothing.
"""
function partitioner(rdd::AbstractRDD)::Union{AbstractPartitioner, Nothing} 
    nothing
end

"""
    compute(rdd::AbstractRDD, partition::Int)

Compute this rdd partition and return an iterator.
"""
function compute(rdd::AbstractRDD, partition::Int)
    deps = dependencies(rdd, partition)
    iterator(
        rdd, 
        partition, 
        Iterators.flatten([[compute(dep.rdd, part) for part in dep.partitions] for dep in deps]) |> collect
    )
end

zero(::AbstractRDD{T}) where T = zero(T)

end
