class Shapes
  def initialize(stream)
    @shapes = stream.map(&:chomp).slice_after('').map do |lines|
      if lines[-1] == ''
        lines.pop
      end
      lines.map{|line| line.each_char.to_a}
    end
    @pos = 0
  end

  def get
    shape = @shapes[@pos]
    @pos = (@pos + 1) % @shapes.size
    shape
  end
end

class Wind
  def initialize(line)
    @directions = line.chomp.each_char.map do |c|
      case c
      when '<' then -1
      when '>' then 1
      else raise 'unknown direction'
      end
    end
    @pos = 0
  end

  def get
    direction = @directions[@pos]
    @pos = (@pos + 1) % @directions.size
    direction
  end
end

class Stack
  WIDTH = 7
  BOTTOM_ROW = ['+', '-' * WIDTH, '+'].join
  EMPTY_ROW = ['|', ' ' * WIDTH, '|'].join

  def initialize
    @stack = [BOTTOM_ROW]
  end

  def height
    @stack.size - 1
  end

  def add(shape, wind)
    (3 + shape.size).times{@stack << EMPTY_ROW.clone}
    x, y = 0, 2
    loop do
      dy = wind.get
      if fits(shape, x, y + dy)
        y = y + dy
      end
      dx = 1
      if fits(shape, x + dx, y)
        x = x + dx
      else
        break
      end
    end
    add_shape_at(shape, x, y)
    prune()
  end

  def fits(shape, x, y)
    shape.each_with_index do |row, sx|
      row.each_with_index do |c, sy|
        if c == '#' && self[x + sx, y + sy] != ' '
          return false
        end
      end
    end
    true
  end

  def [](x, y)
    raise unless x >= 0 && x < @stack.size
    @stack[-1 - x][y + 1]
  end

  def []=(x, y, value)
    raise unless x >= 0 && x < @stack.size && y >= 0 && y < WIDTH
    @stack[-1 - x][y + 1] = value
  end

  def add_shape_at(shape, x, y)
    shape.each_with_index do |row, sx|
      row.each_with_index do |c, sy|
        if c == '#'
          self[x + sx, y + sy] = c
        end
      end
    end
  end

  def prune
    while @stack.last == EMPTY_ROW
      @stack.pop
    end
  end
end
