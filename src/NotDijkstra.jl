module NotDijkstra

using LinearAlgebra
using Random
using SparseArrays
using TropicalNumbers

export make_graph
function make_graph(n::Int)
    # Invent random directed graph
    Random.seed!(5)
    A = sprand(n, n, 2/n)
    # Convert nonzero entries to tropical numbers
    I,J,V = findnz(A)
    V = TropicalMinPlusF64.(V)
    # Set diagonal to zero
    append!(I, 1:n)
    append!(J, 1:n)
    append!(V, LinRange(0, 0, n))
    A = sparse(I, J, V)
    return A
end

export make_initial
function make_initial(n::Int)
    # All vertices are unreachable
    x = zeros(TropicalMinPlusF64, n)
    # The first vertex is reachable with zero cost
    x[1] = 0
    return x
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
