module Scheduler

using ..AbstractRDDModule
using ..AbstractRDDModule: deprdd

export build_dag

struct Node
    rdd::AbstractRDD
    parent::Vector{Node}
end

function build_dag(rdd::AbstractRDD)::Node
    Node(
        rdd,
        Iterators.flatten([build_node(dep) for dep in dependencies(rdd)]) |> collect
    )
end

function build_node(dep::AbstractDependency)::Vector{Node}
    if dep isa NarrowDependency
        Iterators.flatten([build_node(d) for d in dependencies(deprdd(dep))]) |> collect
    elseif dep isa WideDependency
        [build_dag(deprdd(dep))]
    else
        error("Unknown dependency type $(typeof(dep))")
    end
end

end
