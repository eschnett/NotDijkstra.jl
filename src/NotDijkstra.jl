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
    # All vertices are unreachable
    x = fill(Inf, n)
    # The first vertex is reachable with zero cost
    x[1] = 0
    return TropicalMinPlus.(x)
end

export find_costs
function find_costs(A::AbstractMatrix, x::AbstractVector)
    makenice(a) = round(a.n; digits=3)
    y = x
    while true
        println(makenice.(y))
        ynew = A * y
        ynew == y && break
        y = ynew
    end
    return y
end

end
