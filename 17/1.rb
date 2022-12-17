#!/usr/bin/env ruby

require_relative 'common'

shapes = Shapes.new(open('shapes'))
wind = Wind.new(ARGF.read)
stack = Stack.new

2022.times{stack.add(shapes.get, wind)}
puts stack.height
