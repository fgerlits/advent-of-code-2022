#!/usr/bin/env ruby

require_relative 'common'

grid, steps = parse_input(ARGF)
puts grid.state
puts
steps.each{|num, dir| p [num, dir]; grid.step!(num); grid.turn!(dir); puts grid.state; puts}
puts grid.password
