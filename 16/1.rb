#!/usr/bin/env ruby

require 'set'
require_relative 'common'

cave = Cave.new(ARGF)
graph = graph(cave)

vertices = cave.nodes_with_flow
vertices = vertices - ['AT', 'TO', 'NA', 'XX', 'UD', 'YD']

puts max_on_vertices(vertices, cave, graph, 30)
