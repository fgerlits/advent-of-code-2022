#!/usr/bin/env ruby

require_relative 'common'

monkeys = ARGF.map{|line| name, rest = line.chomp.split(': '); [name, Monkey.new(rest)]}.to_h
puts monkeys['root'].value(monkeys)
