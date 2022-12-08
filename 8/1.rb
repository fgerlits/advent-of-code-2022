#!/usr/bin/env ruby

def parse_input(stream)
  stream.map{|line| line.chomp.each_char.map(&:to_i)}
end

def num_visible(grid)
  collect_visible(grid).uniq.size
end

def collect_visible(grid)
  collect_visible_from_side(grid) + collect_visible_from_side(grid.transpose).map(&:reverse)
end

def collect_visible_from_side(grid)
  width = grid[0].size
  collect_visible_from_left(grid) + \
  collect_visible_from_left(grid.map(&:reverse)).map{|x, y| [x, width - 1 - y]}
end

def collect_visible_from_left(grid)
  grid.each_with_index
    .map{|row, x| collect_visible_from_left_in_row(row).map{|y| [x, y]}}
    .flatten(1)
end

def collect_visible_from_left_in_row(row)
  max = -1
  indices = []
  row.each_with_index do |elt, i|
    if elt > max
      indices << i
      max = elt
    end
  end
  indices
end

grid = parse_input(ARGF)
puts num_visible(grid)
