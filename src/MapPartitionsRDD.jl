module MapPartitionsRDDModule

using ..AbstractRDDModule
import ..AbstractRDDModule: partitions, iterator

export MapPartitionsRDD

"""
    struct MapPartitionsRDD{T} <: AbstractRDD{T}
        
Type of an rdd whose partitions are derived from a parent rdd partitions by application of a map function.
"""
struct MapPartitionsRDD{T} <: AbstractRDD{T} 
    f # Map function
    parentrdd::AbstractRDD
end

"""
    struct MapPartitionIterator{T} <: AbstractPartitionIterator{T}

Iterator that returns parent partition element transformed by a map function.
"""
struct MapPartitionIterator{T} <: AbstractPartitionIterator{T}
    f # Map function
    parentiter::AbstractPartitionIterator
end


Base.iterate(iter::MapPartitionIterator{T}, state=nothing) where {T} = begin
    iterresult = Base.iterate(iter.parentiter, state)
    if !isnothing(iterresult)
        return iter.f(iterresult[1]), iterresult[2]
    end
    return nothing
    
end

Base.length(partiter::MapPartitionIterator{T})  where {T} = Base.length(partiter.parentiter)

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

    MapPartitionIterator{T}(rdd.f, parentiters[1])

end

end