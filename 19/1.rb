#!/usr/bin/env ruby

require_relative 'common'

blueprints = parse_input(ARGF).to_h

resources = {'ore' => 0, 'clay' => 0, 'obsidian' => 0, 'geode' => 0}
robots = {'ore' => 1, 'clay' => 0, 'obsidian' => 0, 'geode' => 0}
nodes = [Node.new(0, resources, robots)]

rules = blueprints[1]
24.times do
  nodes = nodes.map{|node| node.next_nodes(rules)}.flatten(1).sort.uniq
  puts nodes
  puts
end
