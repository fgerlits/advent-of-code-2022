#!/usr/bin/env ruby

require_relative 'common'

elves = parse_input(ARGF)
puts to_string(elves)

directions = ['N', 'S', 'W', 'E']

(1..10).each do |round|
  puts "\n#{round}"
  elves = step(elves, directions)
  puts to_string(elves)
  directions = rotate(directions)
end

puts
puts count_empty_ground(elves)
