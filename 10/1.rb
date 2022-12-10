#!/usr/bin/env ruby

require_relative 'common'

input = parse_input(ARGF)
output = execute(input)

TEST_CYCLES = [20, 60, 100, 140, 180, 220]
signal_strengths = TEST_CYCLES.map{|cycle| output[cycle] * cycle}
puts signal_strengths.sum
