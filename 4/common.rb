class Interval
  attr_reader :x, :y

  def initialize(str)
    @x, @y = str.split('-').map(&:to_i)
    raise unless @x <= @y
  end

  def contains?(other)
    @x <= other.x && other.y <= @y
  end

  def overlaps?(other)
    (other.x < @x && other.y >= @x) ||
    (other.x >= @x && other.x <= @y)
  end
end

def parse_input
  ARGF.readlines.map{|line| line.split(',').map{|str| Interval.new(str)}}
end
