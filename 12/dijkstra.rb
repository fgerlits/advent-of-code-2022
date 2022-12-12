require 'rubygems'
require 'algorithms'
require 'set'

INFINITY = 10 ** 100

# input: array of [from_vertex, to_vertex, weight] weighted edges, and the starting vertex
# output: hash of {vertex => distance} giving the weighted distance from the starting vertex
def dijkstra(edges, start)
  vertices = Set.new(edges.map{|from, _, _| from}) + Set.new(edges.map{|_, to, _| to})

  edge_map = edges.each_with_object(Hash.new{Array.new}) do |edge, hash|
    hash[edge[0]] += [edge]
  end

  distances = Hash.new(INFINITY)
  distances[start] = 0

  heap = Containers::MinHeap.new
  vertices.each do |vertex|
    heap.push([INFINITY, vertex], vertex)
  end
  heap.change_key([INFINITY, start], [0, start])

  while !heap.empty?
    current = heap.pop
    if distances[current] == INFINITY
      break
    end

    edge_map[current].each do |_, to, weight|
      old_distance = distances[to]
      new_distance = distances[current] + weight
      if new_distance < old_distance
        distances[to] = new_distance
        heap.change_key([old_distance, to], [new_distance, to])
      end
    end
  end

  distances
end
