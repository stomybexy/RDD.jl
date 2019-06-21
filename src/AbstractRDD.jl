
module AbstractRDDModule

using DocStringExtensions

export AbstractRDD,
    Dependency,
    AbstractPartitioner,
    partitions,
    preferredlocations,
    dependencies,
    iterator,
    partitioner,
    compute

"""
Parent type of rdds.
"""
abstract type AbstractRDD{T} end

"""
Type of rdd dependency. 
"""
struct Dependency
    rdd::AbstractRDD
    partitions::AbstractVector{Int}
    type::Symbol
end

"""
Parent type of rdd partitioner.
"""
abstract type AbstractPartitioner end

""" 
    partitions(rdd::AbstractRDD)::Int64

Returns the number of partitions of the given rdd.
This method must be implemented by subclasses of [`AbstractRDD`](@ref).
The default implementation raises an error.
"""
function partitions(rdd::AbstractRDD)::Int64
    error("method partitions(::$(typeof(rdd))) has not bean implemented")
end

""" 
    preferredlocations(rdd::AbstractRDD, partition::Int)::AbstractVector{Int}

Returns the list of workers where it is preferable to compute this `partition`.
The list is ordered by preference.
"""
preferredlocations(rdd::AbstractRDD, partition::Int)::AbstractVector{Int} = Int[]

""" 
    dependencies(rdd::AbstractRDD, partition::Int)::AbstractVector{Dependency}

Returns the list of parent rdds partitions `partition` of `rdd` depends on 
with the type of the dependency.
"""
dependencies(rdd::AbstractRDD, partition::Int)::AbstractVector{Dependency} = Dependency[]

""" 
    iterator(rdd::AbstractRDD, partition::Int, parentiters::AbstractVector)

Returns an iterator on a partition of the rdd given parent partition(s) iterators.
This method must be implemented by subclasses of [`AbstractRDD`](@ref).
"""
function iterator(rdd::AbstractRDD, partition::Int, parentiters::AbstractVector)
    error("method iterator(::$(typeof(rdd)),::$(typeof(partition))) has not bean implemented")
end

"""
    partitioner(rdd::AbstractRDD)::Union{AbstractPartitioner, Nothing}

Returns the partitioner of this rdd.
Default implementation returns nothing.
"""
partitioner(rdd::AbstractRDD)::Union{AbstractPartitioner, Nothing} = nothing

"""
    compute(rdd::AbstractRDD, partition::Int)

Compute this rdd partition and return an iterator.
"""
function compute(rdd::AbstractRDD, partition::Int)
    deps = dependencies(rdd, partition)
    iterator(
        rdd, 
        partition, 
        Iterators.flatten([[compute(dep.rdd, part) for part in dep.partitions] for dep in deps]) |> collect
    )
end

end
