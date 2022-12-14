def range(from, to)
  if from <= to
    (from .. to)
  else
    (to .. from)
  end
end

class Cave
  def initialize(lines)
    @grid = []
    @x_min = @x_max = 500
    @y_min = @y_max = 0
    lines.each{|line| add_rock(line)}
  end

  def add_rock(line)
    line.split(' -> ').each_cons(2)
      .map{|pair| pair.map{|coords| coords.split(',').map(&:to_i)}}
      .each{|from, to| add_rock_line(from, to)}
  end

  def add_rock_line(from, to)
    if from[0] == to[0]
      range(from[1], to[1]).each{|y| set(from[0], y, '#')}
    elsif from[1] == to[1]
      range(from[0], to[0]).each{|x| set(x, from[1], '#')}
    else
      raise 'Cannot draw diagonal line of rock'
    end
  end

  def set(x, y, value)
    raise unless x >= 0 && y >= 0
    if @grid[x].nil?
      @grid[x] = []
    end
    @grid[x][y] = value
    @x_min = [@x_min, x].min
    @x_max = [@x_max, x].max
    @y_min = [@y_min, y].min
    @y_max = [@y_max, y].max
  end

  def at(x, y)
    if @floor && y == @floor
      '#'
    elsif @grid[x].nil? ||  @grid[x][y].nil?
      '.'
    else
      @grid[x][y]
    end
  end

  def to_s
    (@y_min .. @y_max).map{|y| (@x_min .. @x_max).map{|x| at(x, y)}.join}.join("\n")
  end

  def add_sand!
    x, y = 500, 0
    if at(x, y) != '.'
      return false
    end

    loop do
      if y > @y_max
        return false
      end

      x_, y_ = x, y + 1
      if at(x_, y_) == '.'
        x, y = x_, y_
        next
      end

      x_, y_ = x - 1, y + 1
      if at(x_, y_) == '.'
        x, y = x_, y_
        next
      end

      x_, y_ = x + 1, y + 1
      if at(x_, y_) == '.'
        x, y = x_, y_
        next
      end

      set(x, y, 'o')
      return true
    end
  end

  def set_floor!
    if !@floor
      @floor = @y_max + 2
      @y_max = @floor
    end
  end
end
