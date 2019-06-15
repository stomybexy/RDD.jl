
module AbstractRDDModule

using DocStringExtensions

export AbstractRDD,
    AbstractDependency,
    AbstractPartitioner,
    partitions,
    preferredlocations,
    dependencies,
    iterator,
    partitioner

"""
Parent type of rdds.
"""
abstract type AbstractRDD{T} end

"""
Parent type of rdd partitions preferred locations.
"""
abstract type AbstractLocation end

"""
Parent type of rdd dependencies.
"""
abstract type AbstractDependency end

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
    )::AbstractVector{AbstractLocation} where {T} 

Returns the list of preffered locations ordered by preference for a partition of an rdd.
The default implementation returns no preffered locations.
"""
function preferredlocations(
            rdd::AbstractRDD{T}, 
            partition::Int
        )::AbstractVector{AbstractLocation} where {T} 
    []
end

""" 
    dependencies(rdd::AbstractRDD)::AbstractVector{AbstractDependency}

Returns the list of parent rdds with a specification of the way this rdd depends on each one.
"""
function dependencies(rdd::AbstractRDD)::AbstractVector{AbstractDependency} 
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

end
