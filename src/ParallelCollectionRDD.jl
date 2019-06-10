module ParallelCollectionRDDModule

using DocStringExtensions

using Distributed, Random
using ..AbstractRDDModule
import ..AbstractRDDModule: partitions, iterator

export ParallelCollectionRDD,
        ParallelCollectionPartitionIterator

"""
    struct ParallelCollectionPartition{T} <: AbstractPartition{T}

Type of a partition of [`ParallelCollectionRDD`](@ref)
"""
struct ParallelCollectionPartition{T}
    idxrange::NTuple{2, Int}
end

"""
    struct ParallelCollectionRDD{T} <: AbstractRDD{T}

A subclass of AbstractRDD representing distributed in-memory collection.
"""
struct ParallelCollectionRDD{T} <: AbstractRDD{T}
    parts::AbstractVector{ParallelCollectionPartition{T}}
    colsymbol::Symbol
end

"""
    struct ParallelCollectionPartitionIterator{T} <: AbstractPartitionIterator{T}

Type of the iterator of a [`ParallelCollectionPartition`](@ref)
"""
struct ParallelCollectionPartitionIterator{T} <: AbstractPartitionIterator{T}
    values::Vector{T}
end

Base.iterate(partiter::ParallelCollectionPartitionIterator{T}, state=1) where {T} = begin
    Base.iterate(partiter.values, state)
end

Base.length(partiter::ParallelCollectionPartitionIterator{T})  where {T} = Base.length(partiter.values)

"""
    ParallelCollectionRDD{T}(col::AbstractVector{T}) where {T}

Create a [`ParallelCollectionRDD`](@ref) from a vector.
The number of partitions will be the number of workers of a julia cluster as returned by workers().
If there is less than 2 workers, 2 partitions will be created.
"""
function ParallelCollectionRDD{T}(col::AbstractVector{T}) where {T}
    ParallelCollectionRDD{T}(col, max(workers() |> length, 2))
end

"""
    ParallelCollectionRDD{T}(col::AbstractVector{T}, numpart::Int) where {T}

Create a [`ParallelCollectionRDD`](@ref) from a vector with `numpart` partitions.
"""
function ParallelCollectionRDD{T}(col::AbstractVector{T}, numpart::Int) where {T}
    colsymbol = Symbol(randstring(10))
    @eval $colsymbol = $col

    partsize = ceil(length(col) / numpart) |> Int
    parts = map(1:1:numpart) do p
        ((p - 1) * partsize + 1, min(p * partsize, length(col))) |> ParallelCollectionPartition{T}
    end
    ParallelCollectionRDD{T}(parts, colsymbol)
end

"""
    partitions(
            rdd:: ParallelCollectionRDD{T}
        )::Int64 where {T}

Implementation of [`partitions`](@ref) for [`ParallelCollectionRDD`](@ref).
"""
function partitions(rdd:: ParallelCollectionRDD{T})::Int64 where {T} 
    rdd.parts |> length
end

""" 
    iterator(
        rdd::ParallelCollectionRDD{T}, 
        numpart::Int
    )::ParallelCollectionPartitionIterator{T} where {T}

Implementation of [`iterator`](@ref) for [`ParallelCollectionRDD`](@ref).
"""
function iterator(
        rdd::ParallelCollectionRDD{T}, numpart::Int
    )::ParallelCollectionPartitionIterator{T} where {T}

        idxstart, idxend = rdd.parts[numpart].idxrange

        ParallelCollectionPartitionIterator{T}(@fetchfrom 1 eval(rdd.colsymbol)[idxstart:1:idxend])
end

end
