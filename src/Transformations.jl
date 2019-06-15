module Transformations

using ..AbstractRDDModule, ..MapPartitionsRDDModule
import Base: map, filter, collect

export flatmap

"""
    map(f, rdd::AbstractRDD, type::Type = Any)::AbstractRDD{type}   

Generates a new rdd by transforming elements of `rdd` with function f.
type should be the returned type of map function `f`.
"""
function map(f, rdd::AbstractRDD, type::Type = Any)::AbstractRDD{type}
    MapPartitionsRDD{type}(iter -> Base.Generator(f, iter), rdd)
end
    
"""
    filter(f, rdd::AbstractRDD{T})::AbstractRDD{T} where {T}

Returns a filtered rdd from `rdd` with the given filter function `f`.
"""
function filter(f, rdd::AbstractRDD{T})::AbstractRDD{T} where {T}
    MapPartitionsRDD{T}(iter -> (x for x in iter if f(x)), rdd)
end
    
"""
    flatmap(f, rdd::AbstractRDD, type::Type = Any)::AbstractRDD{type}

Given a rdd and a function `f` that returns an iterator, returns a rdd whose elements are those 
coming from all the iterators f(x) for x in parent `rdd`.
"""
function flatmap(f, rdd::AbstractRDD, type::Type = Any)::AbstractRDD{type}
    MapPartitionsRDD{type}(iter -> Iterators.flatten((f(x) for x in iter)), rdd)
end

end