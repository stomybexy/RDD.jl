# using Pkg
# Pkg.activate("$(@__DIR__)/..")
# push!(LOAD_PATH, "$(@__DIR__)/../src/")
using Documenter, RDD

# Workaround for JuliaLang/julia/pull/28625
if Base.HOME_PROJECT[] !== nothing
    Base.HOME_PROJECT[] = abspath(Base.HOME_PROJECT[])
end

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
