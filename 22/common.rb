def valid?(tile)
  tile == '.' || tile == '#'
end

def blocked?(tile)
  tile == '#'
end

class Grid
  def initialize(lines)
    @grid = lines.map{|line| line.each_char.to_a}
    @pos = [0, left_of_row(0)]
    @heading = [0, 1]
  end

  def left_of_row(x)
    @grid[x].index{|tile| valid?(tile)}
  end

  def right_of_row(x)
    @grid[x].rindex{|tile| valid?(tile)}
  end

  def top_of_column(y)
    @grid.index{|row| valid?(row[y])}
  end

  def bottom_of_column(y)
    @grid.rindex{|row| valid?(row[y])}
  end

  def at(pos)
    x, y = pos
    x >= 0 && @grid[x] && y >= 0 && @grid[x][y]
  end

  def step!(num)
    num.times do
      pos, heading = @pos.zip(@heading).map{|coord, diff| coord + diff}, @heading
      if !valid?(at(pos))
        pos, heading = wrap(self, pos, @heading)
      end
      if blocked?(at(pos))
        return
      else
        @pos, @heading = pos, heading
      end
    end
  end

  TURN_LEFT = {[0, 1] => [-1, 0], [1, 0] => [0, 1], [0, -1] => [1, 0], [-1, 0] => [0, -1]}
  TURN_RIGHT = {[0, 1] => [1, 0], [1, 0] => [0, -1], [0, -1] => [-1, 0], [-1, 0] => [0, 1]}

  def turn!(dir)
    case dir
    when 'L'
      @heading = TURN_LEFT[@heading]
    when 'R'
      @heading = TURN_RIGHT[@heading]
    end
  end

  HEADING_VALUES = {[0, 1] => 0, [1, 0] => 1, [0, -1] => 2, [-1, 0] => 3}

  def password
    x, y = @pos
    (x + 1) * 1000 + (y + 1) * 4 + HEADING_VALUES[@heading]
  end

  NAME_OF_HEADING = {[0, 1] => 'right', [1, 0] => 'down', [0, -1] => 'left', [-1, 0] => 'up'}

  def state
    "#{@pos.map{|coord| coord + 1}}, heading: #{NAME_OF_HEADING[@heading]}"
  end
end

class Steps
  def initialize(line)
    @steps = line.scan(/(\d+)([LR])?/).map{|num, turn| [num.to_i, turn]}
  end

  def each
    @steps.each{|step| yield step}
  end
end

def parse_input(stream)
  grid, steps = stream.map(&:chomp).slice_after('').to_a
  [Grid.new(grid[...-1]), Steps.new(steps[0])]
end
