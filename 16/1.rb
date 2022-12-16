#!/usr/bin/env ruby

require 'set'
require_relative 'common'

cave = Cave.new(ARGF)
graph = graph(cave)

vertices = cave.nodes_with_flow
vertices = vertices - ['AT', 'TO', 'NA', 'XX', 'UD', 'YD']

totals = vertices.permutation.map do |path|
  path = path.map do |step|
    if step == 'FI'
      ['FI', 'AT', 'TO']
    elsif step == 'KB'
      ['KB', 'NA', 'XX', 'UD', 'YD']
    else
      step
    end
  end.flatten(1)

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
