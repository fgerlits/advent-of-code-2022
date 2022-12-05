#!/usr/bin/env ruby

require_relative 'common'

stacks, moves = parse_input(ARGF)
moves.each do |move|
  move.apply2(stacks)
end
puts top_crates_of(stacks)
