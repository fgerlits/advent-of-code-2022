#!/usr/bin/env ruby

input = ARGF.readlines.map(&:chomp)
elves = input.slice_after('')
calories_carried = elves.map{|elf| elf.map(&:to_i).sum}

puts calories_carried.max
puts calories_carried.sort.reverse.take(3).sum
