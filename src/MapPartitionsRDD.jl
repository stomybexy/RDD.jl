module MapPartitionsRDDModule

using ..AbstractRDDModule
import ..AbstractRDDModule: partitions, iterator

export MapPartitionsRDD

"""
    struct MapPartitionsRDD{T} <: AbstractRDD{T}
        
Type of an rdd whose partitions are derived from a parent rdd partitions by application of a map function.
"""
struct MapPartitionsRDD{T} <: AbstractRDD{T} 
    f # Map function applied to partition iterator
    parentrdd::AbstractRDD
end

"""
    partitions(rdd::MapPartitionsRDD)::Int64

Implementation of [`partitions`](@ref) for [`MapPartitionsRDD`](@ref).
Returns the same partitions count as parent rdd.
"""
partitions(rdd::MapPartitionsRDD)::Int64 = partitions(rdd.parentrdd)

"""
    iterator(
        rdd::MapPartitionsRDD, 
        part::Int, 
        parentiters::AbstractVector{AbstractPartitionIterator}
    )::AbstractPartitionIterator{T} where {T}

Implementation of [`iterator`](@ref) for [`MapPartitionsRDD`](@ref).
Returns the elements of parent partition transformed by map function.
"""
function iterator(
    rdd::MapPartitionsRDD{T}, 
    part::Int,
    parentiters::AbstractVector{AbstractPartitionIterator}
)::AbstractPartitionIterator{T} where {T}

    rdd.f(parentiters[1])

end

end