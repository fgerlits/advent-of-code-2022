require 'set'

DIRECTIONS = ['<', '>', 'v', '^']

def parse_input(stream)
  lines = stream.map(&:chomp)

  x_size = lines.size - 2
  y_size = lines[0].size - 2

  entrance_column = lines[0].index('.')
  exit_column = lines[-1].index('.')

  blizzards = []
  lines.each_with_index do |row, x|
    row.each_char.with_index do |c, y|
      if DIRECTIONS.include?(c)
        blizzards << [x, y, c]
      end
    end
  end
  
  [x_size, y_size, entrance_column, exit_column, Set.new(blizzards)]
end

def step(blizzards)
  Set.new(blizzards.map{|blizzard| step_one(blizzard)})
end

def step_one(blizzard)
  x, y, c = blizzard
  case c
  when '<'
    if y == 1 then y = Y_SIZE + 1 end
    [x, y - 1, c]
  when '>'
    if y == Y_SIZE then y = 0 end
    [x, y + 1, c]
  when 'v'
    if x == X_SIZE then x = 0 end
    [x + 1, y, c]
  when '^'
    if x == 1 then x = X_SIZE + 1 end
    [x - 1, y, c]
  end
end

def to_grid(blizzards)
  (1..X_SIZE).map do |x|
    blizzards.each_with_object('#' + '.' * Y_SIZE + '#') do |blizzard, row|
      bx, by, bc = blizzard
      if bx == x
        if row[by] == '.'
          row[by] = bc
        elsif DIRECTIONS.include?(row[by])
          row[by] = '2'
        elsif row[by] =~ /\d/
          row[by] = (row[by].to_i + 1).to_s
        end
      end
    end
  end
end

class State
  attr_reader :my_pos

  def initialize(my_pos, blizzards_num)
    @my_pos = my_pos
    @blizzards_num = blizzards_num
  end

  def as_array = [@my_pos, @blizzards_num]
  def hash = as_array.hash
  def eql?(other) = as_array.eql?(other.as_array)
  def ==(other) = eql?(other)

  def neighbors
    [[0, 0], [-1, 0], [1, 0], [0, -1], [0, 1]].map do |direction|
      if can_move?(direction)
        move(direction)
      end
    end.compact
  end

  def new_pos(direction) = @my_pos.zip(direction).map{|coord, diff| coord + diff}

  def new_blizzards_num = (@blizzards_num + 1) % BLIZZARDS_INVENTORY.size

  def new_blizzards = BLIZZARDS_INVENTORY[new_blizzards_num]

  def can_move?(direction)
    x, y = new_pos(direction)
    if x == 0
      y == ENTRANCE_COLUMN
    elsif x >= 1 && x <= X_SIZE && y >= 1 && y <= Y_SIZE
      DIRECTIONS.none?{|dir| new_blizzards.include?([x, y, dir])}
    elsif x == X_SIZE + 1
      y == EXIT_COLUMN
    end
  end

  def move(direction)
    State.new(new_pos(direction), new_blizzards_num)
  end

  def to_s
    top = '#' * (Y_SIZE + 2)
    top[ENTRANCE_COLUMN] = '.'

    middle = to_grid(BLIZZARDS_INVENTORY[@blizzards_num])

    bottom = '#' * (Y_SIZE + 2)
    bottom[EXIT_COLUMN] = '.'
    
    grid = [top] + middle + [bottom]
    grid[@my_pos[0]][@my_pos[1]] = 'E'
    "#{@my_pos}\n" + grid.join("\n")
  end
end

def length_of_shortest_path(state)
  visited = Set.new([state])
  todo_list = [[state, 0]]

  while !todo_list.empty?
    state, num_steps = todo_list.shift

    if yield(state.my_pos)
      return [num_steps, state]
    end

    neighbors = state.neighbors
    neighbors.each do |neighbor|
      if !visited.include?(neighbor)
        visited << neighbor
        todo_list << [neighbor, num_steps + 1]
      end
    end
  end
end

def find_all_blizzards(blizzards)
  seen_at = {blizzards => 0}
  (1..).each do |n|
    blizzards = step(blizzards)
    if seen_at[blizzards]
      return seen_at.map{|blizzards, n| [n, blizzards]}.to_h
    else
      seen_at[blizzards] = n
    end
  end
end
