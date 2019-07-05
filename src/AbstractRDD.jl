
module AbstractRDDModule

using DocStringExtensions

export AbstractRDD,
    Dependency,
    AbstractPartitioner,
    AbstractDependency,
    NarrowDependency,
    WideDependency,
    OneToOneDependency,
    ShuffleDependency,
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

abstract type AbstractDependency end
abstract type NarrowDependency <: AbstractDependency end
abstract type WideDependency <: AbstractDependency end

struct OneToOneDependency <: NarrowDependency
    rdd::AbstractRDD
end
struct ShuffleDependency <: WideDependency
    rdd::AbstractRDD
end

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

deprdd(dep::AbstractDependency)::AbstractRDD = dep.rdd 

function deppartitions(dep::AbstractDependency, part::Int)::Vector{Int} end
deppartitions(dep::OneToOneDependency, part::Int) = [part]
deppartitions(dep::ShuffleDependency, part::Int) = 1:(deprdd(dep) |> partitions) |> collect

""" 
    dependencies(rdd::AbstractRDD)::Vector{AbstractDependency}

Returns the list of dependencies of `rdd`
"""
dependencies(rdd::AbstractRDD)::Vector{AbstractDependency} = AbstractDependency[]

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
    deps = dependencies(rdd)
    iterator(
        rdd, 
        partition, 
        Iterators.flatten([[compute(deprdd(dep), part) for part in deppartitions(dep, part)] for dep in deps]) |> collect
    )
end

end
