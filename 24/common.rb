require 'set'

def parse_input(stream)
  Grid.new(stream.to_a)
end

DIRECTIONS = ['<', '>', 'v', '^']

class Grid
  attr_reader :blizzards, :my_pos
  attr_writer :blizzards, :my_pos

  def initialize(lines)
    @x_size = lines.size - 2
    @y_size = lines[0].chomp.size - 2

    blizzards = []
    lines.each_with_index do |row, x|
      row.each_char.with_index do |c, y|
        if DIRECTIONS.include?(c)
          blizzards << [x, y, c]
        end
      end
    end
    @blizzards = Set.new(blizzards)

    @entrance = lines[0].index('.')
    @exit = lines[-1].rindex('.')

    @my_pos = [0, @entrance]
  end

  def hash = [@my_pos, @blizzards].hash

  def eql?(other)
    @my_pos == other.my_pos && @blizzards.eql?(other.blizzards)
  end

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
      y == @entrance
    elsif x >= 1 && x <= @x_size && y >= 1 && y <= @y_size
      DIRECTIONS.none?{|dir| @blizzards.include?([x, y, dir])}
    elsif x == @x_size + 1
      y == @exit
    end
  end

  def move(direction)
    new_grid = self.clone
    new_grid.my_pos = @my_pos.zip(direction).map{|coord, diff| coord + diff}
    new_grid
  end

  def step_blizzards
    new_grid = self.clone
    new_grid.blizzards = @blizzards.map{|blizzard| step(blizzard)}
    new_grid
  end

  def step(blizzard)
    x, y, c = blizzard
    case c
    when '<'
      if y == 1 then y = @y_size + 1 end
      [x, y - 1, c]
    when '>'
      if y == @y_size then y = 0 end
      [x, y + 1, c]
    when 'v'
      if x == @x_size then x = 0 end
      [x + 1, y, c]
    when '^'
      if x == 0 then x = @x_size + 1 end
      [x - 1, y, c]
    end
  end

  def at_exit?
    @my_pos == [@x_size + 1, @exit]
  end

  def to_s
    top = '#' * (@y_size + 2)
    top[@entrance] = '.'

    bottom = '#' * (@y_size + 2)
    bottom[@exit] = '.'

    middle = (1..@x_size).map do |x|
      row = '#' + '.' * @y_size + '#'
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
    
    grid = [top] + middle + [bottom]
    grid[@my_pos[0]][@my_pos[1]] = 'E'
    "#{@my_pos}\n" + grid.join("\n")
  end
end
