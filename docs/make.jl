using Pkg
Pkg.activate("$(@__DIR__)/..")
push!(LOAD_PATH, "$(@__DIR__)/../src/")
using Documenter, RDD

makedocs(sitename = "RDD Documentation")

# Deploy built documentation from Travis.
# =======================================

deploydocs(
    # options
    repo = "github.com/stomybexy/RDD.jl.git",
    target = "build",
    deps = nothing,
    make = nothing
)
