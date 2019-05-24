module ParallelCollectionRDDModule

using Distributed, Random
using ..AbstractRDDModule
import ..AbstractRDDModule: partitions, iterator

export ParallelCollectionRDD,
        ParallelCollectionPartition,
        ParallelCollectionPartitionIterator

struct ParallelCollectionPartition{T} <: AbstractPartition{T}
    idxrange::NTuple{2, Int}
end

struct ParallelCollectionRDD{T} <: AbstractRDD{T}
    parts::AbstractVector{ParallelCollectionPartition{T}}
    colsymbol::Symbol
end

struct ParallelCollectionPartitionIterator{T} <: AbstractPartitionIterator{T}
    values::Vector{T}
end

Base.iterate(partiter::ParallelCollectionPartitionIterator{T}, state=1) where {T} = begin
    Base.iterate(partiter.values, state)
end

Base.length(partiter::ParallelCollectionPartitionIterator{T})  where {T} = Base.length(partiter.values)

function ParallelCollectionRDD{T}(col::AbstractVector{T}) where {T}
    ParallelCollectionRDD{T}(col, max(workers() |> length, 2))
end
function ParallelCollectionRDD{T}(col::AbstractVector{T}, numpart::Int) where {T}
    colsymbol = Symbol(randstring(10))
    @eval $colsymbol = $col

    partsize = ceil(length(col) / numpart) |> Int
    parts = map(1:1:numpart) do p
        ((p - 1) * partsize + 1, min(p * partsize, length(col))) |> ParallelCollectionPartition{T}
    end
    ParallelCollectionRDD{T}(parts, colsymbol)
end

function partitions(rdd:: ParallelCollectionRDD{T})::AbstractVector{ParallelCollectionPartition{T}} where {T} 
    rdd.parts
end

function iterator(
        rdd::ParallelCollectionRDD{T}, numpart::Int,
        parent_iters::AbstractVector{AbstractPartitionIterator})::ParallelCollectionPartitionIterator{T} where {T}

        idxstart, idxend = rdd.parts[numpart].idxrange

        ParallelCollectionPartitionIterator{T}(@fetchfrom 1 eval(rdd.colsymbol)[idxstart:1:idxend])
end

end