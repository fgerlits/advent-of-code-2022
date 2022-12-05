#!/usr/bin/env ruby

require_relative 'common'

puts parse_input().count{|left, right| left.contains?(right) || right.contains?(left)}
