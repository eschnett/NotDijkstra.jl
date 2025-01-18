# NotDijkstra.jl

Find the shorted paths through a graph -- not via Dijkstra's
algorithm, but using linear algebra and tropical numbers.

## Example

```julia
julia> using NotDijkstra
julia> A = make_graph(10)
julia> x = make_initial(10)
julia> find_costs(A, x)
```
