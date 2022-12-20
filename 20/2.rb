#!/usr/bin/env ruby

require_relative 'common'

cycle = Cycle.new(ARGF, 811589153)
10.times{ cycle.mix! }
puts cycle.grove_coordinates.sum
