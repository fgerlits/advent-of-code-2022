#!/usr/bin/env ruby

input = ARGF.read.chomp.each_char.to_a

first_marker = input.each_with_index.each_cons(4).find{|packet| packet.map{|c, i| c}.uniq.size == 4}
puts first_marker[-1][1] + 1
