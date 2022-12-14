#!/usr/bin/env ruby

require_relative 'common'

cave = Cave.new(ARGF.readlines)
cave.set_floor!
num_sand = 0
while cave.add_sand!
  num_sand += 1
end
puts num_sand
