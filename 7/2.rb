#!/usr/bin/env ruby

require_relative 'common'

DISK_SPACE_TOTAL = 70_000_000
FREE_SPACE_NEEDED = 30_000_000

root_dir = parse_input(ARGF)
current_free_space = DISK_SPACE_TOTAL - root_dir.size
need_to_free_up = FREE_SPACE_NEEDED - current_free_space

sizes = collect_directories(root_dir).map{|dir| dir.size}
puts sizes.select{|size| size >= need_to_free_up}.min
