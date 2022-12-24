require 'set'

def parse_input(stream)
  Grid.new(stream.to_a)
end

class Grid
  def initialize(lines)
    @x_size = lines.size - 2
    @y_size = lines[0].chomp.size - 2

    blizzards = []
    lines.each_with_index do |row, x|
      row.each_char.with_index do |c, y|
        if ['<', '>', 'v', '^'].include?(c)
          blizzards << [x, y, c]
        end
      end
    end
    @blizzards = Set.new(blizzards)

    @my_pos = lines[0].index('.')
    @exit = lines[-1].rindex('.')
  end

  def to_s
    top = '#' * (@y_size + 2)
    top[@my_pos] = '.'

    bottom = '#' * (@y_size + 2)
    bottom[@exit] = '.'

    middle = (1..@x_size).map do |x|
      row = '#' + '.' * @y_size + '#'
      @blizzards.each do |bx, by, bc|
        if bx == x
          row[by] = bc
        end
      end
      row
    end

    ([top] + middle + [bottom]).join("\n")
  end
end
