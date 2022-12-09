#!/usr/bin/env ruby

require_relative 'common'

input = parse_input(ARGF)

rope = [[0, 0]] * 10
visited = [[0, 0]]

input.each do |direction, count|
  count.times do
    rope[0] = move(rope[0], direction)
    (1...rope.size).each do |i|
      rope[i] = follow(rope[i], rope[i - 1])
    end
    visited << rope[-1]
  end
end

puts visited.uniq.size
