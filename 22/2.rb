#!/usr/bin/env ruby

require_relative 'common'

RIGHT, DOWN, LEFT, UP = [0, 1], [1, 0], [0, -1], [-1, 0]

def wrap(grid, pos, heading)
  x, y = pos
  if x == -1 && y < 100 && heading == UP                    # ab
    [[y + 100, 0], RIGHT]
  elsif x == -1 && y >= 100 && heading == UP                # be
    [[199, y - 100], UP]
  elsif y == 49 && x < 50 && heading == LEFT                # ac
    [[149 - x, 0], RIGHT]
  elsif y == 150 && x < 50 && heading == RIGHT              # ef
    [[149 - x, 99], LEFT]
  elsif x == 50 && y >= 100 && heading == DOWN              # df
    [[y - 50, 99], LEFT]
  elsif y == 49 && x >= 50 && x < 100 && heading == LEFT    # cg
    [[100, x - 50], DOWN]
  elsif y == 100 && x >= 50 && x < 100 && heading == RIGHT  # df
    [[49, x + 50], UP]
  elsif x == 99 && y < 50 && heading == UP                  # cg
    [[y + 50, 50], RIGHT]
  elsif x >= 100 && x < 150 && y == -1 && heading == LEFT   # ac
    [[149 - x, 50], RIGHT]
  elsif x >= 100 && x < 150 && y == 100 && heading == RIGHT # ef
    [[149 - x, 149], LEFT]
  elsif x == 150 && y >= 50 && y < 100 && heading == DOWN   # eh
    [[y + 100, 49], LEFT]
  elsif x >= 150 && y == -1 && heading == LEFT              # ab
    [[0, x - 100], DOWN]
  elsif x >= 150 && y == 50 && heading == RIGHT             # eh
    [[149, x - 100], UP]
  elsif x == 200 && y < 50 && heading == DOWN               # be
    [[0, y + 100], DOWN]
  else
    raise "couldn't wrap #{pos} with heading #{heading}"
  end
end

grid, steps = parse_input(ARGF)
steps.each{|num, dir| grid.step!(num); grid.turn!(dir)}
puts grid.password
