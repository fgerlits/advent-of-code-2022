#!/usr/bin/env ruby

module Enumerable
  def take_while_including
    found = []
    self.each do |elt|
      found << elt 
      if !yield(elt)
        break
      end
    end
    found
  end
end

def parse_input(stream)
  stream.map{|line| line.chomp.each_char.map(&:to_i)}
end

def scenic_scores(grid)
  (0...grid.size).map do |x|
    (0...grid[x].size).map do |y|
      num_trees_visible(grid, [x, y]).inject(:*)
    end
  end
end

def num_trees_visible(grid, coords)
  x, y = coords
  [num_visible_in_line(grid[x].slice(y..)),
   num_visible_in_line(grid[x].slice(..y).reverse),
   num_visible_in_line(grid.transpose[y].slice(x..)),
   num_visible_in_line(grid.transpose[y].slice(..x).reverse)]
end

def num_visible_in_line(row)
  max = row[0]
  row[1..].take_while_including{|elt| elt < max}.size
end

grid = parse_input(ARGF)
puts scenic_scores(grid).flatten.max
