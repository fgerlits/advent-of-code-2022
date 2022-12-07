#!/usr/bin/env ruby

require_relative 'common'

root_dir = parse_input(ARGF)

sizes = collect_directories(root_dir).map{|dir| dir.size}
puts sizes.select{|size| size < 100_000}.sum
