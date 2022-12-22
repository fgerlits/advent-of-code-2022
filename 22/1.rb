#!/usr/bin/env ruby

require_relative 'common'

grid, steps = parse_input(ARGF)
steps.each{|num, dir| grid.step!(num); grid.turn!(dir)}
puts grid.password
