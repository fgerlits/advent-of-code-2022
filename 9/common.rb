def parse_input(stream)
  stream.readlines.map do |line|
    line =~ /([LRDU]) (\d+)/
    [$1, $2.to_i]
  end
end

def move(point, direction)
  x, y = point
  case direction
  when 'L'
    [x - 1, y]
  when 'R'
    [x + 1, y]
  when 'D'
    [x, y - 1]
  when 'U'
    [x, y + 1]
  end
end

class Numeric
  def sign
    if self < 0 then -1
    elsif self > 0 then 1
    else 0
    end
  end
end

def follow(tail, head)
  tx, ty = tail
  hx, hy = head
  
  distx = (hx - tx).abs
  disty = (hy - ty).abs

  if distx <= 1 && disty <= 1
    [tx, ty]
  else
    dx = (hx - tx).sign
    dy = (hy - ty).sign

    [tx + dx, ty + dy]
  end
end
