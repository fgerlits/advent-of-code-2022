#!/usr/bin/env ruby

require_relative 'common'

def opposite(face)
  face.map{|coord| -coord}
end

def adjacent_faces(face)
  FACES - [face, opposite(face)]
end

def neighboring_faces(cube, face, cubes)
  adjacent_faces(face).map do |f|
    out_cube = neighbor_at(cube, face)
    out_and_f = neighbor_at(out_cube, f)
    flat_and_f = neighbor_at(cube, f)
    in_and_f = cube

    if cubes.include?(out_and_f)
      [out_and_f, opposite(f)]
    elsif cubes.include?(flat_and_f)
      [flat_and_f, face]
    else
      [in_and_f, f]
    end
  end
end

cubes = parse_input(ARGF)

min_x = cubes.map{|x, y, z| x}.min
starting_cube = cubes.find{|cube| cube[0] == min_x}
start = [starting_cube, [-1, 0, 0]]

visited = Set.new([start])
todo_list = [start]

while !todo_list.empty?
  current_cube, current_face = todo_list.shift

  neighboring_faces(current_cube, current_face, cubes).each do |cube, face|
    if !visited.include?([cube, face])
      visited << [cube, face]
      todo_list << [cube, face]
    end
  end
end

puts visited.size
