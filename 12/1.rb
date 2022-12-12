#!/usr/bin/env ruby

require_relative 'common'
require_relative 'dijkstra'

def allowed?(from, to)
  to <= from || to.ord == from.ord + 1
end

edges, start, finish = create_graph(parse_input(ARGF))
distances = dijkstra(edges, start)
puts distances[finish]
