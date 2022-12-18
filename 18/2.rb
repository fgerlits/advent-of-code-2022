#!/usr/bin/env ruby

require 'set'
require_relative 'common'

class CubeProperties
  def initialize
    @painted_faces = []
  end

  def mark_exposed(cube, cubes)
    @exposed_faces = FACES.select{|face| !cubes.include?(neighbor_at(cube, face))}
  end

  def one_exposed_face = @exposed_faces.first

  def exposed?(face) = @exposed_faces.include?(face)

  def paint(face)
    @painted_faces << face
  end

  def num_painted = @painted_faces.size
end

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
cube_set = Set.new(cubes)
cube_pties = cubes.map{|cube| [cube, CubeProperties.new]}.to_h
cube_pties.each{|cube, pties| pties.mark_exposed(cube, cube_set)}

limits = cubes.transpose.map(&:minmax)
min_x = limits[0][0]
starting_cube = cubes.find{|cube| cube[0] == min_x}
starting_face = cube_pties[starting_cube].one_exposed_face

visited = Set.new([[starting_cube, starting_face]])
todo_list = [[starting_cube, starting_face]]

while !todo_list.empty?
  current_cube, current_face = todo_list.shift
  cube_pties[current_cube].paint(current_face)

  neighboring_faces(current_cube, current_face, cube_set).each do |cube, face|
    if cube_set.include?(cube) && cube_pties[cube].exposed?(face) && !visited.include?([cube, face])
      visited << [cube, face]
      todo_list << [cube, face]
    end
  end
end

puts cube_pties.map{|_, pties| pties.num_painted}.sum
