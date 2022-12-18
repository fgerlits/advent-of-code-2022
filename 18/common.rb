def neighbors(cube)
  x, y, z = cube
  [[-1, 0, 0], [1, 0, 0], [0, -1, 0], [0, 1, 0], [0, 0, -1], [0, 0, 1]].map do |dx, dy, dz|
    [x + dx, y + dy, z + dz]
  end
end

def num_exposed_sides(cube, cubes)
  6 - neighbors(cube).count{|neighbor| cubes.include?(neighbor)}
end

def parse_input(stream)
  stream.map{|line| line.split(',').map(&:to_i)}
end
