#!/usr/bin/env ruby

require 'set'
require_relative 'common'

def length_of_shortest_path(grid)
  visited = Set.new([grid])
  todo_list = [[grid, 0]]
  steps = 0

  while !todo_list.empty?
    grid, num_steps = todo_list.shift

    if grid.at_exit?
      return num_steps
    end

    if num_steps > steps
      puts num_steps
      steps = num_steps
    end

    grid = grid.step_blizzards

    neighbors = grid.neighbors
    neighbors.each do |neighbor|
      if !visited.include?(neighbor)
        visited << neighbor
        todo_list << [neighbor, num_steps + 1]
      end
    end
  end
end
    
grid = parse_input(ARGF)
puts length_of_shortest_path(grid)
