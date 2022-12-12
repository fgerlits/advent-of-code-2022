#!/usr/bin/env ruby

require_relative 'common'

monkeys = parse_input(ARGF)

$modulus = monkeys.map{|monkey| monkey.test.factor}.inject(:*)

def reduce(number) = number

10_000.times { iterate(monkeys) }

puts monkeys.map(&:num_inspected).sort.reverse.take(2).inject(:*)
