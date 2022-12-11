#!/usr/bin/env ruby

require_relative 'common'

monkeys = parse_input(ARGF)
modulus = monkeys.map{|monkey| monkey.test.factor}.inject(:*)
monkeys.each{|monkey| monkey.set_modulus(modulus)}

10_000.times do
  monkeys.each do |monkey|
    while thrown = monkey.throw_one(nil)
      item, target = thrown
      monkeys[target].catch_one(item)
    end
  end
end

puts monkeys.map(&:num_inspected).sort.reverse.take(2).inject(:*)
