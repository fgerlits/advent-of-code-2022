def compare(left, right)
  if left.nil?
    -1
  elsif right.nil?
    1
  elsif left.is_a?(Integer) && right.is_a?(Integer)
    left <=> right
  elsif left.is_a?(Integer)
    compare([left], right)
  elsif right.is_a?(Integer)
    compare(left, [right])
  else
    zip(left, right).map{|l, r| compare(l, r)}.find{|val| val != 0} || 0
  end
end

def zip(left, right)
  if left.size >= right.size
    left.zip(right)
  else
    right.zip(left).map{|r, l| [l, r]}
  end
end
