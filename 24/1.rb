#!/usr/bin/env ruby

require_relative 'common'
    
X_SIZE, Y_SIZE, ENTRANCE_COLUMN, EXIT_COLUMN, blizzards = parse_input(ARGF)
BLIZZARDS_INVENTORY = find_all_blizzards(blizzards)
puts "found #{BLIZZARDS_INVENTORY.size} different blizzard configurations"

start = State.new([0, ENTRANCE_COLUMN], 1)
num, _ = length_of_shortest_path(start) {|pos| pos == [X_SIZE + 1, EXIT_COLUMN]}
puts num
