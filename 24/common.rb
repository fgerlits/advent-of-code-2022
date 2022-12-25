require 'set'

def parse_input(stream)
  lines = stream.map(&:chomp)

  x_size = lines.size - 2
  y_size = lines[0].size - 2

  entrance_column = lines[0].index('.')
  exit_column = lines[-1].rindex('.')

  blizzards = []
  lines.each_with_index do |row, x|
    row.each_char.with_index do |c, y|
      if DIRECTIONS.include?(c)
        blizzards << [x, y, c]
      end
    end
  end
  
  [x_size, y_size, entrance_column, exit_column, Blizzards.new(blizzards)]
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

DIRECTIONS = ['<', '>', 'v', '^']

class Blizzards
  attr_reader :blizzards

  def initialize(array)
    @blizzards = Set.new(array)
  end
  
  def step
    Blizzards.new(@blizzards.map{|blizzard| step_one(blizzard)})
  end

  def to_grid
    (1..X_SIZE).map do |x|
      row = '#' + '.' * Y_SIZE + '#'
      @blizzards.each do |bx, by, bc|
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
      row
    end
  end

  def to_s
    to_grid.join("\n")
  end

  def hash = @blizzards.hash
  def eql?(other) = @blizzards.eql?(other.blizzards)
  def ==(other) = eql?(other)
end


class State
  def initialize(my_pos, blizzards_num)
    @my_pos = my_pos
    @blizzards_num = blizzards_num
  end

  def as_array = [@my_pos, @blizzards_num]
  def hash = as_array.hash
  def eql?(other) = as_array.eql?(other.as_array)
  def ==(other) = eql?(other)

  def neighbors
    ns = [[0, 0], [-1, 0], [1, 0], [0, -1], [0, 1]].map do |direction|
      if can_move?(direction)
        move(direction)
      end
    end.compact
  end

  def can_move?(direction)
    x, y = @my_pos.zip(direction).map{|coord, diff| coord + diff}
    if x == 0
      y == ENTRANCE_COLUMN
    elsif x >= 1 && x <= X_SIZE && y >= 1 && y <= Y_SIZE
      blizzards = BLIZZARDS_INVENTORY[@blizzards_num]
      DIRECTIONS.none?{|dir| blizzards.include?([x, y, dir])}
    elsif x == X_SIZE + 1
      y == EXIT_COLUMN
    end
  end

  def move(direction)
    new_pos = @my_pos.zip(direction).map{|coord, diff| coord + diff}
    new_blizzards_num = (@blizzards_num + 1) % BLIZZARDS_INVENTORY.size
    State.new(new_pos, new_blizzards_num)
  end

  def at_exit?
    @my_pos == [X_SIZE + 1, EXIT_COLUMN]
  end

  def to_s
    top = '#' * (Y_SIZE + 2)
    top[ENTRANCE_COLUMN] = '.'

    middle = BLIZZARDS_INVENTORY[@blizzards_num].to_grid

    bottom = '#' * (Y_SIZE + 2)
    bottom[EXIT_COLUMN] = '.'
    
    grid = [top] + middle + [bottom]
    grid[@my_pos[0]][@my_pos[1]] = 'E'
    "#{@my_pos}\n" + grid.join("\n")
  end
end
