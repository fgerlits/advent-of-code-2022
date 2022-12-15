#!/usr/bin/env ruby

require_relative 'common'

MIN = 0
MAX = ARGV.shift.to_i
beacons, balls = parse_input(ARGF)

intersections = MIN.upto(MAX).map do |y|
  intersections = balls.map{|ball| ball.intersect_y(y)}.compact
  if !intersections.empty?
    [merge_intervals(intersections), y]
  end
end.compact

free_places = intersections.map do |intervals, y|
  if intervals.first.from > MIN
    [MIN, y]
  elsif intervals.first.to < MAX
    [intervals.first.to + 1, y]
  end
end.compact

raise unless free_places.size == 1
x, y = free_places.first
puts MAX * x + y
