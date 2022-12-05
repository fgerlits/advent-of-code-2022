#!/usr/bin/env ruby

def to_compartments(line)
  items = line.each_char.to_a
  size = items.size / 2
  [items.slice(0, size), items.slice(size, size)]
end

def prio(item)
  if 'a' <= item && item <= 'z'
    item.ord - 'a'.ord + 1
  else
    item.ord - 'A'.ord + 27
  end
end

rucksacks = ARGF.readlines.map{|line| to_compartments(line.chomp)}
common_items = rucksacks.map{|r| r[0] & r[1]}
priorities = common_items.map{|items| prio(items[0])}
puts priorities.sum
