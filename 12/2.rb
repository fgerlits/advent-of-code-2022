#!/usr/bin/env ruby

require_relative 'common'
require_relative 'dijkstra'

def allowed?(from, to)
  to >= from || to.ord == from.ord - 1
end

heightmap = parse_input(ARGF)
edges, _, start = create_graph(heightmap)
distances = dijkstra(edges, start)

puts distances.select{|vertex, _| i, j = vertex; h = heightmap[i][j]; h == 'a' || h == 'S'}
    .map{|_, distance| distance}
    .min
