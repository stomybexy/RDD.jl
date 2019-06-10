using Documenter, RDD

# Workaround for JuliaLang/julia/pull/28625
if Base.HOME_PROJECT[] !== nothing
    Base.HOME_PROJECT[] = abspath(Base.HOME_PROJECT[])
end

makedocs(
    sitename = "RDD Documentation",
    pages = Any[
        "Home" => "index.md",
        "Library" => Any[
            "AbstractRDD" => "lib/abstract_rdd.md",
            "ParallelCollectionRDD" => "lib/parallel_collection_rdd.md",
        ]
    ]
)

# Deploy built documentation from Travis.
# =======================================

deploydocs(
    # options
    repo = "github.com/stomybexy/RDD.jl.git",
    target = "build",
    deps = nothing,
    make = nothing
)
