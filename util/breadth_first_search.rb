require 'set'

# input: array of [from_vertex, to_vertex] edges, and the starting vertex
# output: hash of {vertex => distance} giving the distance from the starting vertex
def breadth_first_search(edges, start)
  edge_map = edges.each_with_object(Hash.new{Array.new}) do |edge, hash|
    hash[edge[0]] += [edge[1]]
  end

  distances = {}
  distances[start] = 0

  visited = Set.new
  visited << start

  todo_list = [start]
  while !todo_list.empty?
    from = todo_list.shift
    edge_map[from].each do |to|
      if !visited.include?(to)
        distances[to] = distances[from] + 1
        visited << to
        todo_list << to
      end
    end
  end

  distances
end
