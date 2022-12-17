#!/usr/bin/env ruby

require_relative 'common'

NUM_SHAPES_DROPPED = ARGV.shift.to_i
$stack_height = {}

def find_loop
  shapes = Shapes.new(open('shapes'))
  wind = Wind.new(ARGF.read)
  stack = Stack.new

  first_seen = {}
  (1..).each do |counter|
    stack.add(shapes.get, wind)
    $stack_height[counter] = stack.height

    if shapes.pos == 0
      loop_start  = first_seen[[wind.pos, stack.last(10)]]
      if !loop_start.nil?
        return [loop_start, counter - loop_start]
      end
      first_seen[[wind.pos, stack.last(10).clone]] = counter
    end
  end
end

loop_start, loop_length = find_loop()

stack_increment_in_loop = $stack_height[loop_start + loop_length] - $stack_height[loop_start]
num_full_cycles, num_remainder = (NUM_SHAPES_DROPPED - loop_start).divmod(loop_length)
stack_increment_in_remainder = $stack_height[loop_start + num_remainder] - $stack_height[loop_start]

puts $stack_height[loop_start] + num_full_cycles * stack_increment_in_loop + stack_increment_in_remainder
