module Transformations

using ..AbstractRDDModule, ..MapPartitionsRDDModule
import Base: map, filter, collect

############################ map ##########################

"""
    struct MapPartitionIterator{T} <: AbstractPartitionIterator{T}

Iterator that returns parent partition elements transformed by a map function.
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
    map(f, rdd::AbstractRDD, type::Type{T} = Any)::AbstractRDD where {T}

Generates a new rdd by transforming elements of `rdd` with function f.
type should be the returned type of map function `f`.
"""
function map(f, rdd::AbstractRDD, type::Type{T} = Any)::AbstractRDD where {T}
    MapPartitionsRDD{type}(iter -> MapPartitionIterator{T}(f, iter), rdd)
end

########################## filter ############################
"""
    FilterPartitionIterator{T} <: AbstractPartitionIterator{T}

Iterator that filters parent partition iterator elements with predicate `f`.
"""
struct FilterPartitionIterator{T} <: AbstractPartitionIterator{T}
    f # filter function T -> Boolean
    parentiter::AbstractPartitionIterator
end

Base.iterate(iter::FilterPartitionIterator{T}, state=nothing) where {T} = begin
    local iterresult = Base.iterate(iter.parentiter, state)
    while !isnothing(iterresult)
        if iter.f(iterresult[1])
            return iterresult
        end
        iterresult = Base.iterate(iter.parentiter, state)
    end
    return nothing
end


# inefficient, but usefull for tests
function collect(iter::FilterPartitionIterator{T})::AbstractVector{T} where {T}
    result = T[]
    for elt in iter 
        push!(result, elt)
    end
    result
end

"""
    filter(f, rdd::AbstractRDD{T})::AbstractRDD{T} where {T}

Returns a filtered rdd from `rdd` with the given filter function `f`.
"""
function filter(f, rdd::AbstractRDD{T})::AbstractRDD{T} where {T}
    MapPartitionsRDD{T}(iter -> FilterPartitionIterator{T}(f, iter), rdd)
end

end