#!/usr/bin/env ruby

require_relative 'common'

cycle = Cycle.new(ARGF)
(0...cycle.size).each{|index| cycle.move!(index)}
index = (0...cycle.size).find{|index| cycle.at(index).value == 0}
coords = 3.times.map do
  1000.times{ index = cycle.at(index).succ }
  cycle.at(index).value
end
puts coords.sum
