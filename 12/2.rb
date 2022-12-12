#!/usr/bin/env ruby

require_relative 'common'
require_relative 'dijkstra'

def allowed?(from, to)
  to >= from || to.ord == from.ord - 1
end

heightmap = parse_input(ARGF)
edges, _, start = create_graph(heightmap)
distances = dijkstra(edges, start)

finishes = heightmap.map.with_index do |row, i|
  row.map.with_index do |height, j|
    if height == 'a' || height == 'S'
      [i, j]
    end
  end.compact
end.flatten(1)

puts finishes.map{|i, j| distances[[i, j]]}.min
