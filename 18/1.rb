#!/usr/bin/env ruby

require 'set'
require_relative 'common'

cubes = Set.new(parse_input(ARGF))
puts cubes.map{|cube| num_exposed_sides(cube, cubes)}.sum
