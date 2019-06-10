module Transformations

using ..AbstractRDDModule, ..MapPartitionsRDDModule
import Base: map

"""
    map(f, rdd::AbstractRDD, type::Type{T} = Any)::AbstractRDD where {T}

Returns a [`MapPartitionsRDD{type}`](@ref) from `rdd` with the given map function `f`.
type should be the returned type of map function `f`.
"""
function map(f, rdd::AbstractRDD, type::Type{T} = Any)::AbstractRDD where {T}
    MapPartitionsRDD{type}(f, rdd)
end

end