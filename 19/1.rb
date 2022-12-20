#!/usr/bin/env ruby

require_relative 'common'

def run(node, rules)
  24.times{ node = node.random_step(rules) }
  node
end

blueprints = parse_input(ARGF)

resources = {'ore' => 0, 'clay' => 0, 'obsidian' => 0, 'geode' => 0}
robots = {'ore' => 1, 'clay' => 0, 'obsidian' => 0, 'geode' => 0}
starting_node = Node.new(0, resources, robots)

num_geodes = blueprints.map do |index, rules|
  1000.times.map{ run(starting_node, rules).num_geodes }.max
end

p num_geodes
