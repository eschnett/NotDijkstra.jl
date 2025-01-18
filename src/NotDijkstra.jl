module NotDijkstra

using LinearAlgebra
using Random
using SparseArrays
using TropicalNumbers

export make_graph
function make_graph(n::Int)
    # Invent random directed graph
    Random.seed!(5)
    A = Matrix(sprand(n, n, 2/n))
    # Replace zeros by infinity
    A = map(a -> ifelse(a==0, Inf, abs(a)), A)
    # Set diagonal to zero
    for i in 1:size(A,1)
        A[i,i] = 0
    end
    # Convert to tropical matrix
    return TropicalMinPlus.(A)
end

export make_initial
function make_initial(n::Int)
    x = fill(Inf, n)
    x[1] = 0
    return TropicalMinPlus.(x)
end

export find_costs
"""
julia> using NotDijkstra
julia> A = make_graph(10)
julia> x = make_initial(10)
julia> find_costs(A, x)
"""
function find_costs(A::AbstractMatrix, x::AbstractVector)
    makenice(a) = round(a.n; digits=3)
    y = x
    for n in 0:10
        println("$n: $(makenice.(y))")
        y = A * y
    end
    return
end

end
