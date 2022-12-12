def neighbors(i, j)
  ([[-1, 0], [1, 0], [0, -1], [0, 1]]).map{|di, dj| [i + di, j + dj]}
      .select{|x, y| x >= 0 && x < $x_size && y >= 0 && y < $y_size}
end

def parse_input(stream)
  stream.readlines.map{|line| line.chomp.each_char.to_a}
end

def create_graph(heightmap)
  $x_size = heightmap.size
  $y_size = heightmap[0].size
  
  start = nil
  finish = nil
  heightmap.each_with_index do |row, i|
    row.each_with_index do |height, j|
      if height == 'S'
        start = [i, j]
      end
      if height == 'E'
        finish = [i, j]
      end
    end
  end
  raise unless !start.nil? && !finish.nil?
  heightmap[start[0]][start[1]] = 'a'
  heightmap[finish[0]][finish[1]] = 'z'

  edges = []
  heightmap.each_with_index do |row, i|
    row.each_with_index do |height, j|
      neighbors(i, j).each do |ni, nj|
        if allowed?(heightmap[i][j], heightmap[ni][nj])
          edges << [[i, j], [ni, nj], 1]
        end
      end
    end
  end

  [edges, start, finish]
end
