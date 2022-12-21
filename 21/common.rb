class Monkey
  def initialize(str)
    if str =~ /\d+/
      @number = str.to_i
    else
      @arg1, @op, @arg2 = str.split
    end
  end

  def children
    if @number
      []
    elsif @arg2.nil?
      [@arg1]
    else
      [@arg1, @arg2]
    end
  end

  def value(monkeys)
    if @number
      @number
    elsif @arg2.nil?
      monkeys[@arg1].value(monkeys)
    else
      left, right = monkeys[@arg1].value(monkeys), monkeys[@arg2].value(monkeys)
      case @op
      when '+' then left + right
      when '-' then left - right
      when '*' then left * right
      when '/' then left / right
      end
    end
  end
end
