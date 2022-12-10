#!/usr/bin/env ruby

require_relative 'common'

input = parse_input(ARGF)
output = execute(input)

SCREEN_HEIGHT = 6
SCREEN_WIDTH = 40

screen = SCREEN_HEIGHT.times.map do |row|
  SCREEN_WIDTH.times.map do |column|
    cycle = SCREEN_WIDTH * row + column + 1
    if (column - output[cycle]).abs <= 1 then '#' else ' ' end
  end
end

puts screen.map(&:join).join("\n")
