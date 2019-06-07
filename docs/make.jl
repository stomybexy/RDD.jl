using Pkg
pkg"activate .."
push!(LOAD_PATH, "../src/")
using Documenter, RDD

makedocs(sitename = "RDD Documentation")
