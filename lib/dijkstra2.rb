require_relative 'graph'
require_relative 'priority_map'

# O(|V| + |E|*log(|V|)).
def dijkstra2(source)
  shortest_paths = {}
  possible_paths = PriorityMap.new do |data1, data2|
    data1[:cost] <=> data2[:cost]
  end
  possible_paths[source] = { cost: 0, edge: nil }
  until possible_paths.empty?
    vertex,data = possible_paths.extract
    
    if shortest_paths[vertex].nil? || shortest_paths[vertex][:cost] > data[:cost]
      shortest_paths[vertex] = data

      vertex.out_edges.each do |edge|
        if possible_paths[edge.to_vertex].nil? || possible_paths[edge.to_vertex][:cost] > data[:cost] + edge.cost
          possible_paths[edge.to_vertex] = { edge:edge , cost: data[:cost] + edge.cost }
        end
      end
    end

  end

  shortest_paths
end
