require_relative 'graph'

# O(|V|**2 + |E|).
def dijkstra1(source)
  shortest_paths = {}
  possible_paths = {source => { edge: nil, cost: 0}}
  until possible_paths.empty?
    vertex = possible_paths.keys.first
    data = possible_paths[vertex]

    if shortest_paths[vertex].nil? || shortest_paths[vertex][:cost] > data[:cost]
      shortest_paths[vertex] = data
      sorted = vertex.out_edges.sort { |edge1, edge2| edge1.cost <=> edge2.cost }
      sorted.each do |edge|
        if possible_paths[edge.to_vertex].nil? || possible_paths[edge.to_vertex][:cost] > data[:cost] + edge.cost
          possible_paths[edge.to_vertex] = { edge:edge , cost: data[:cost] + edge.cost }
        end
      end
    end
    possible_paths.delete(vertex)

  end

  shortest_paths
end
