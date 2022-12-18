FACES = [[-1, 0, 0], [1, 0, 0], [0, -1, 0], [0, 1, 0], [0, 0, -1], [0, 0, 1]]

def neighbor_at(cube, direction)
  cube.zip(direction).map{|coord, diff| coord + diff}
end

def neighbors(cube)
  FACES.map{|face| neighbor_at(cube, face)}
end

def num_exposed_sides(cube, cubes)
  6 - neighbors(cube).count{|neighbor| cubes.include?(neighbor)}
end

def parse_input(stream)
  stream.map{|line| line.split(',').map(&:to_i)}
end
