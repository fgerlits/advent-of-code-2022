#!/usr/bin/env ruby

require_relative 'common'

input = ARGF.readlines.map(&:chomp).reject(&:empty?).map{|line| eval(line)}
dividers = [[[2]], [[6]]]
sorted = (input + dividers).sort{|left, right| compare(left, right)}
puts dividers.map{|div| sorted.index(div) + 1}.inject(:*)
