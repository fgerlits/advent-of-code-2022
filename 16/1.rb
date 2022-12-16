#!/usr/bin/env ruby

require 'set'
require_relative 'common'

START_NODE = 'AA'
cave = Cave.new(ARGF)

visited = Set.new
states = [[[], State.new(START_NODE, [])]]
paths = (1..14).map do |n|
  puts "#{n} -> #{states.size}"
  states.each{|path, state| visited << state}
  states = states.map do |path, state|
    state.continuations(cave).map{|step| [path + [step], state.apply(step)]}
      .select{|path, state| !visited.include?(state)}
  end.flatten(1)
end.flatten(1)

puts paths.map{|path, state| value(path, cave)}.max
