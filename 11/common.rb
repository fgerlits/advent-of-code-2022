class Operation
  def initialize(line)
    line =~ /new = old ([^ ]) ([^ ]+)/
    @op = $1
    if $2 == 'old'
      @arg = :old
    else
      @arg = $2.to_i
    end
  end

  def apply(number)
    if @arg == :old
      arg = number
    else
      arg = @arg
    end

    result = case @op
      when '+' then number + arg
      when '-' then number - arg
      when '*' then number * arg
      when '/' then number / arg
    end

    if $modulus
      result % $modulus
    else
      result
    end
  end
end

class Test
  attr_reader :factor

  def initialize(line)
    line =~ /divisible by (\d+)/
    @factor = $1.to_i
  end

  def apply(number)
    number % @factor == 0
  end
end

class Monkey
  attr_reader :num_inspected, :test

  def initialize(lines)
    @items = lines[0].scan(/\d+/).map(&:to_i)
    @operation = Operation.new(lines[1])
    @test = Test.new(lines[2])
    lines[3] =~ /If true: throw to monkey (\d+)/; @on_true = $1.to_i
    lines[4] =~ /If false: throw to monkey (\d+)/; @on_false = $1.to_i
    @num_inspected = 0
  end

  def throw_one
    item = @items.shift
    if item.nil?
      return nil
    end

    item = reduce(@operation.apply(item))
    @num_inspected += 1
    if @test.apply(item)
      [item, @on_true]
    else
      [item, @on_false]
    end
  end

  def catch_one(item)
    @items << item
  end
end

def parse_input(stream)
  stream.readlines.map(&:chomp).slice_after('').map{|lines| Monkey.new(lines[1..5])}
end

def iterate(monkeys)
  monkeys.each do |monkey|
    while thrown = monkey.throw_one
      item, target = thrown
      monkeys[target].catch_one(item)
    end
  end
end
