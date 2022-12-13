#!/usr/bin/env ruby

require_relative 'common'
require_relative '../util/breadth_first_search'

def allowed?(from, to)
  to <= from || to.ord == from.ord + 1
end

edges, start, finish = create_graph(parse_input(ARGF))
distances = breadth_first_search(edges, start)
puts distances[finish]
