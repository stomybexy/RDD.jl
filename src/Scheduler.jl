module Scheduler

using ..AbstractRDDModule

struct Node
    rdd::AbstractRDD
    parent::Union{Nothing, Node}
end

function build_dag(rdd::AbstractRDD)::Node
    
end

end
