#!/usr/bin/env ruby

require_relative 'common'

cycle = Cycle.new(ARGF, nil)
cycle.mix!
puts cycle.grove_coordinates.sum
