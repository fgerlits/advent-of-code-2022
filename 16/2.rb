#!/usr/bin/env ruby

require 'set'
require_relative 'common'

cave = Cave.new(ARGF)
graph = graph(cave)

vertices = cave.nodes_with_flow
vertices = vertices - ['AT', 'TO', 'NA', 'XX', 'UD', 'YD']

flows = 0.upto(vertices.size / 2).map do |my_size|
  vertices.combination(my_size).map do |my_half|
    his_half = vertices - my_half
    max_on_vertices(my_half, cave, graph, 26) + max_on_vertices(his_half, cave, graph, 26)
  end
end.flatten(1)

puts flows.max
