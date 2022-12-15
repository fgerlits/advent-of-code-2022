#!/usr/bin/env ruby

require_relative 'common'

y_coord = ARGV.shift.to_i
beacons, balls = parse_input(ARGF)

intersections = balls.map{|ball| ball.intersect_y(y_coord)}.compact
intervals = merge_intervals(intersections)
num_beacons = intervals.map{|interval| beacons.count{|x, y| y == y_coord && interval.contains?(x)}}.sum

puts intervals.map(&:length).sum - num_beacons
