module Actions

using Distributed, ..AbstractRDDModule

import Base: reduce

function reduce(f, rdd::AbstractRDD{T}, init) where T
    @distributed f for partition in 1:1:partitions(rdd)
        reduce(f, (x for x in compute(rdd, partition)), init)
    end
end

function reduce(f, gen::Base.Generator, init) 
    r = init
    for x in gen
        r = f(r, x)
    end
    r
end

end