module ParallelCollectionRDDModule

using DocStringExtensions

using Distributed, Random
using ..AbstractRDDModule
import ..AbstractRDDModule: partitions, iterator

export ParallelCollectionRDD

struct ParallelCollectionPartition{T}
    idxrange::NTuple{2,Int}
end

"""
    struct ParallelCollectionRDD{T} <: AbstractRDD{T}

A subclass of AbstractRDD representing distributed in-memory collection.
"""
struct ParallelCollectionRDD{T} <: AbstractRDD{T}
    parts::AbstractVector{ParallelCollectionPartition{T}}
    remotevar::Symbol
end

"""
    ParallelCollectionRDD{T}(col::AbstractVector{T}) where T

Create a [`ParallelCollectionRDD`](@ref) from a AbstractVector.
The number of partitions will be the number of workers of a julia cluster as returned by nworkers().
If there is less than 2 workers, 2 partitions will be created.
"""
ParallelCollectionRDD{T}(col::AbstractVector{T}) where T = ParallelCollectionRDD{T}(col, max(workers() |> length, 2))

"""
    ParallelCollectionRDD{T}(col::AbstractVector{T}, numpart::Int) where {T}

Create a [`ParallelCollectionRDD`](@ref) from a AbstractVector with `numpart` partitions.
"""
function ParallelCollectionRDD{T}(col::AbstractVector{T}, numpart::Int) where T
    remotevar = Symbol(randstring(10))
    @eval $remotevar = $col
    partsize = cld(length(col), numpart)
    parts = map(1:1:numpart) do p
        ((p - 1) * partsize + 1, min(p * partsize, length(col))) |> ParallelCollectionPartition{T}
    end
    ParallelCollectionRDD{T}(parts, remotevar)
end

"""
    partitions(rdd::ParallelCollectionRDD)

Implementation of [`partitions`](@ref) for [`ParallelCollectionRDD`](@ref).
"""
partitions(rdd::ParallelCollectionRDD) = rdd.parts |> length

"""
    iterator(rdd::ParallelCollectionRDD, numpart::Int, parentiters::AbstractVector = [])

Implementation of [`iterator`](@ref) for [`ParallelCollectionRDD`](@ref).
"""
function iterator(rdd::ParallelCollectionRDD, numpart::Int, parentiters::AbstractVector = [])
    idxstart, idxend = rdd.parts[numpart].idxrange
    @fetchfrom 1 eval(rdd.remotevar)[idxstart:1:idxend]
end

end
