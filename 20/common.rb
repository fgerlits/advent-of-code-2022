class Node
  attr_reader :value, :prev, :succ
  attr_writer :prev, :succ
  
  def initialize(value, prev, succ)
    @value, @prev, @succ = value, prev, succ
  end
end

class Cycle
  attr_reader :size

  def initialize(stream)
    values = stream.map(&:to_i)
    @size = values.size
    @cycle = values.map.with_index do |value, index|
      Node.new(value, (index - 1) % @size, (index + 1) % @size)
    end
  end

  def at(index)
    @cycle[index % @size]
  end

  def move!(index)
    current = at(index)
    if current.value % (@size - 1) != 0
      at(current.prev).succ = current.succ
      at(current.succ).prev = current.prev

      new_before = index
      (current.value % (@size - 1)).times{ new_before = at(new_before).succ }
      new_after = at(new_before).succ
      at(new_before).succ = index
      current.prev = new_before
      current.succ = new_after
      at(new_after).prev = index
    end
  end

  def to_s
    index = 0
    @cycle.map{value = at(index).value; index = at(index).succ; value}.join(', ')
  end
end
