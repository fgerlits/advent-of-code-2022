#!/usr/bin/env ruby

require 'set'
require_relative 'common'

def length_of_shortest_path(state)
  visited = Set.new([state])
  todo_list = [[state, 0]]
  steps = 0

  while !todo_list.empty?
    state, num_steps = todo_list.shift

    if state.at_exit?
      return num_steps
    end

    if num_steps > steps
      steps = num_steps
    end

    neighbors = state.neighbors
    neighbors.each do |neighbor|
      if !visited.include?(neighbor)
        visited << neighbor
        todo_list << [neighbor, num_steps + 1]
      end
    end
  end
end

def find_all_blizzards(blizzards)
  seen_at = {blizzards => 0}
  (1..).each do |n|
    blizzards = blizzards.step
    seen = seen_at[blizzards]
    if !seen.nil?
      return seen_at.map{|blizzards, n| [n, blizzards.blizzards]}.to_h
    else
      seen_at[blizzards] = n
    end
  end
end
    
X_SIZE, Y_SIZE, ENTRANCE_COLUMN, EXIT_COLUMN, blizzards = parse_input(ARGF)
BLIZZARDS_INVENTORY = find_all_blizzards(blizzards)
puts "found #{BLIZZARDS_INVENTORY.size} different blizzard configurations"

state = State.new([0, ENTRANCE_COLUMN], 1)
puts length_of_shortest_path(state)
