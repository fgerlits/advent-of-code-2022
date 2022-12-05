#!/usr/bin/env ruby

def common_items(triplet)
  triplet.inject(&:&)
end

def prio(item)
  if 'a' <= item && item <= 'z'
    item.ord - 'a'.ord + 1
  else
    item.ord - 'A'.ord + 27
  end
end

rucksacks = ARGF.readlines.map{|line| line.chomp.each_char.to_a}.each_slice(3)
common_items = rucksacks.map{|r| common_items(r)}
priorities = common_items.map{|items| prio(items[0])}
puts priorities.sum
