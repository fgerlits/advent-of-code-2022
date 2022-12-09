#!/usr/bin/env ruby

require_relative 'common'

input = parse_input(ARGF)

head = [0, 0]
tail = [0, 0]
visited = [tail]

input.each do |direction, count|
  count.times do
    head = move(head, direction)
    tail = follow(tail, head)
    visited << tail
  end
end

puts visited.uniq.size
