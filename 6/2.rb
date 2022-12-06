#!/usr/bin/env ruby

input = ARGF.read.chomp.each_char.to_a

SIZE = 14
first_marker = input.each_with_index.each_cons(SIZE)
    .find{|packet| packet.map{|c, i| c}.uniq.size == SIZE}
puts first_marker[-1][1] + 1
