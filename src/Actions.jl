module Actions

using Distributed, Dagger

using ..AbstractRDDModule

import Base: reduce

"""
    reduce(f, rdd::AbstractRDD{T}, init::T) where T

Reduce the elements of `rdd` using the binary function `f` with the init value `init`.
`f`must be commutative and associative and `init` must be neutral for `f`. 
"""
function reduce(f, rdd::AbstractRDD{T}, init::T) where T
    reduce_partition(rdd, partition) = reduce(f, (x for x in AbstractRDDModule.compute(rdd, partition)), init)
    partitions_results = (delayed(reduce_partition)(rdd, partition) for partition in 1:1:partitions(rdd))

    delayed(reduce)(f, init, partitions_results...) |> collect
end

function reduce(f, gen::Base.Generator, init) 
    r = init
    for x in gen
        r = f(r, x)
    end
    r
end

reduce(f, init, values...) = reduce(f, values, init=init)

end