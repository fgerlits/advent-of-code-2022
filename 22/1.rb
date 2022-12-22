#!/usr/bin/env ruby

require_relative 'common'

def wrap(grid, pos, heading)
  x, y = pos
  pos = case heading
  when [0, 1]
    [x, grid.left_of_row(x)]
  when [0, -1]
    [x, grid.right_of_row(x)]
  when [1, 0]
    [grid.top_of_column(y), y]
  when [-1, 0]
    [grid.bottom_of_column(y), y]
  end
  [pos, heading]
end

grid, steps = parse_input(ARGF)
steps.each{|num, dir| grid.step!(num); grid.turn!(dir)}
puts grid.password
