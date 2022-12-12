#!/usr/bin/env ruby

require_relative 'common'

monkeys = parse_input(ARGF)

def reduce(number) = number / 3

20.times { iterate(monkeys) }

puts monkeys.map(&:num_inspected).sort.reverse.take(2).inject(:*)
