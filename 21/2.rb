#!/usr/bin/env ruby

require_relative 'common'

def inverse(op)
  case op
  when '+' then '-'
  when '-' then '+'
  when '*' then '/'
  when '/' then '*'
  end
end

def reverse(input, name)
  found_name = input.find{|item| item[0] == name}
  if found_name
    input.delete(found_name)
    return Monkey.new(found_name[1..].join(' '))
  end
  
  found_left = input.find{|item| item[1] == name}
  if found_left
    input.delete(found_left)
    if found_left[0] == 'root'
      return Monkey.new(found_left[3])
    else
      arg1 = found_left[0]
      op = inverse(found_left[2])
      arg2 = found_left[3]
      return Monkey.new([arg1, op, arg2].join(' '))
    end
  end

  found_right = input.find{|item| item[3] == name}
  if found_right
    input.delete(found_right)
    if found_right[0] == 'root'
      return Monkey.new(found_right[1])
    else
      op = found_right[2]
      if op == '+' || op == '*'
        arg1 = found_right[0]
        op = inverse(op)
        arg2 = found_right[1]
      else
        arg1 = found_right[1]
        arg2 = found_right[0]
      end
      return Monkey.new([arg1, op, arg2].join(' '))
    end
  end

  raise "name #{name} not found anywhere"
end
  
input = ARGF.map{|line| name, rest = line.chomp.split(': '); [name, *rest.split]}
input.reject!{|item| item[0] == 'humn'}

monkeys = []
names = ['humn']
while !names.empty?
  name = names.shift
  monkey = reverse(input, name)
  monkeys << [name, monkey]
  names += monkey.children
end

monkeys = monkeys.to_h
puts monkeys['humn'].value(monkeys)
