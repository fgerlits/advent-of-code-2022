#!/usr/bin/env ruby

require_relative 'common'
require_relative '../util/breadth_first_search'

def allowed?(from, to)
  to >= from || to.ord == from.ord - 1
end

heightmap = parse_input(ARGF)
edges, _, start = create_graph(heightmap)
distances = breadth_first_search(edges, start)

puts distances.select{|vertex, _| i, j = vertex; h = heightmap[i][j]; h == 'a' || h == 'S'}
    .map{|_, distance| distance}
    .min
