module Scheduler

using ..AbstractRDDModule

struct Node
    rdd::AbstractRDD
    parent::Union{Nothing, Node}
end

end
