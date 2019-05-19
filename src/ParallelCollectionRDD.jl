
struct ParallelCollectionPartition{T} <: AbstractPartition{T}

end

struct ParallelCollectionRDD{T} <: AbstractRDD{T}

end

function partitions(rdd:: ParallelCollectionRDD{T})::AbstractVector{ParallelCollectionPartition{T}} where {T} 
    ParallelCollectionPartition{T}[]
end
