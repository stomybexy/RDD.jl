module Actions

using Distributed, ..AbstractRDDModule

import Base: reduce

"""
    reduce(f, rdd::AbstractRDD{T}, init::T) where T

Reduce the elements of `rdd` using the binary function `f` with the init value `init`.
`f`must be commutative and associative and `init` must be neutral for `f`. 
"""
function reduce(f, rdd::AbstractRDD{T}, init::T) where T
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