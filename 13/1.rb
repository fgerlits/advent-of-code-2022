#!/usr/bin/env ruby

require_relative 'common'

input = ARGF.readlines.map(&:chomp).slice_after('').map{|left, right| [eval(left), eval(right)]}
orders = input.map{|left, right| compare(left, right)}
puts orders.each_with_index.select{|order, _| order == -1}.map{|_, index| index + 1}.sum
