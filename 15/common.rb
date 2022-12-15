class Interval
  attr_reader :from, :to

  def initialize(from, to)
    @from = from
    @to = to
    if @from > @to
      @from, @to = @to, @from
    end
  end

  def length
    @to - @from + 1
  end

  def contains?(num)
    @from <= num && num <= @to
  end
end

def merge_intervals(input)
  input.sort_by!(&:from)
  first = input.shift
  curr_x, curr_y = first.from, first.to
  
  result = []
  input.each do |interval|
    x, y = interval.from, interval.to
    if x <= curr_y + 1
      curr_y = [curr_y, y].max
    else
      result << Interval.new(curr_x, curr_y)
      curr_x, curr_y = x, y
    end
  end
  result + [Interval.new(curr_x, curr_y)]
end
      
class Ball
  def initialize(center, radius)
    @center = center
    @radius = radius
  end

  def intersect_y(y)
    dy = (@center[1] - y).abs
    if dy > @radius
      nil
    else
      dx = @radius - dy
      Interval.new(@center[0] - dx, @center[0] + dx)
    end
  end
end

def distance(from, to)
  [from, to].transpose.map{|f, t| (f - t).abs}.sum
end

def parse_input(lines)
  lines.map do |line|
    line =~ /Sensor at x=([-0-9]+), y=([-0-9]+): closest beacon is at x=([-0-9]+), y=([-0-9]+)/
    center = [$1, $2].map(&:to_i)
    beacon = [$3, $4].map(&:to_i)
    radius = distance(center, beacon)
    [beacon, Ball.new(center, radius)]
  end.transpose.map(&:uniq)
end
