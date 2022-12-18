#!/usr/bin/env ruby

require_relative 'common'

cubes = parse_input(ARGF)
puts cubes.map{|cube| num_exposed_sides(cube, cubes)}.sum
