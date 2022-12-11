#!/usr/bin/env ruby

require_relative 'common'

monkeys = parse_input(ARGF)

20.times do
  monkeys.each do |monkey|
    while thrown = monkey.throw_one(3)
      item, target = thrown
      monkeys[target].catch_one(item)
    end
  end
end

puts monkeys.map(&:num_inspected).sort.reverse.take(2).inject(:*)
