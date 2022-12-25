#!/usr/bin/env ruby

def add(left, right)
  if left.length < right.length
    left, right = right, left
  end
  right += [0] * (left.length - right.length)

  carry = 0
  sum = left.zip(right).map{|l, r| s, carry = digits(l + r + carry); s}

  if carry != 0
    sum + [carry]
  else
    sum
  end
end

def digits(value)
  if value < -2 then [value + 5, -1]
  elsif value > 2 then [value - 5, 1]
  else [value, 0]
  end
end

def parse(str)
  str.each_char.map{|c| {'=' => -2, '-' => -1, '0' => 0, '1' => 1, '2' => 2}[c]}.reverse
end

def to_string(num)
  num.reverse.map{|d| {-2 => '=', -1 => '-', 0 => '0', 1 => '1', 2 => '2'}[d]}.join
end

input = ARGF.map(&:chomp).map{|line| parse(line)}
sum = input.inject{|l, r| add(l, r)}
puts to_string(sum)
