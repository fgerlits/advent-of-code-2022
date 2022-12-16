#!/usr/bin/env ruby

require 'set'
require_relative 'common'

cave = Cave.new(ARGF)
vertices = cave.nodes_with_flow
graph = graph(cave)

totals = vertices.permutation.map do |path|
  time = 0
  current = 'AA'
  total = 0
  path.each do |step|
    switched_on_at = time + graph[current][step] + 1
    time = switched_on_at
    if time >= 30
      break
    end
    current = step
    total += (30 - switched_on_at) * cave.flow_at(step)
  end
  [path, total]
end

puts totals.max_by{|_, total| total}
