#!/usr/bin/env ruby

require_relative 'common'

elves = parse_input(ARGF)
puts to_string(elves)

directions = ['N', 'S', 'W', 'E']

(1..).each do |round|
  puts "\n#{round}"
  new_elves = step(elves, directions)
  if elves.sort == new_elves.sort
    break
  end
  elves = new_elves
  puts to_string(elves)
  directions = rotate(directions)
end
