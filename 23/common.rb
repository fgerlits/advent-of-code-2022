require 'set'

def parse_input(stream)
  elves = []
  stream.each_with_index do |line, x|
    line.chomp.each_char.with_index do |c, y|
      if c == '#'
        elves << [x, y]
      end
    end
  end
  elves
end

def to_string(elves)
  min_x, max_x = elves.map(&:first).minmax
  size_x = max_x - min_x + 1
  min_y, max_y = elves.map(&:last).minmax
  size_y = max_y - min_y + 1

  grid = Array.new(size_x) { Array.new(size_y) { '.' } }
  elves.each do |x, y|
    grid[x - min_x][y - min_y] = '#'
  end

  grid.map(&:join).join("\n")
end

def count_empty_ground(elves)
  min_x, max_x = elves.map(&:first).minmax
  size_x = max_x - min_x + 1
  min_y, max_y = elves.map(&:last).minmax
  size_y = max_y - min_y + 1

  size_x * size_y - elves.size
end

def step(elves, directions)
  elves_set = Set.new(elves)
  planned_moves = elves.map{|elf| [elf, plan(elf, elves_set, directions)]}
  single_destinations = Set.new(singles(planned_moves.map{|from, to| to}.compact))
  planned_moves.map do |from, to|
    if single_destinations.include?(to)
      to
    else
      from
    end
  end
end

def plan(elf, elves_set, directions)
  if neighbors(elf).none?{|neighbor| elves_set.include?(neighbor)}
    return nil
  end

  direction = directions.find do |direction|
    three_steps(elf, direction).none?{|step| elves_set.include?(step)}
  end

  if direction
    one_step(elf, direction)
  end
end

def neighbors(elf)
  x, y = elf
  [[-1, -1], [-1, 0], [-1, 1], [0, -1], [0, 1], [1, -1], [1, 0], [1, 1]].map{|dx, dy| [x + dx, y + dy]}
end

def three_steps(elf, direction)
  x, y = elf
  case direction
    when 'N' then [[x - 1, y - 1], [x - 1, y], [x - 1, y + 1]]
    when 'S' then [[x + 1, y - 1], [x + 1, y], [x + 1, y + 1]]
    when 'W' then [[x - 1, y - 1], [x, y - 1], [x + 1, y - 1]]
    when 'E' then [[x - 1, y + 1], [x, y + 1], [x + 1, y + 1]]
  end
end

def one_step(elf, direction)
  x, y = elf
  case direction
    when 'N' then [x - 1, y]
    when 'S' then [x + 1, y]
    when 'W' then [x, y - 1]
    when 'E' then [x, y + 1]
  end
end

def singles(values)
  freqs = values.each_with_object(Hash.new(0)) {|value, hash| hash[value] += 1}
  freqs.select{|value, freq| freq == 1}.map{|value, freq| value}
end

def rotate(array)
  array[1..] + [array[0]]
end
