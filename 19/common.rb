def parse_input(stream)
  stream.map do |line|
    line.chomp =~ /Blueprint (\d+): (.*)/
    [$1.to_i, $2.split('. ').map{|sentence| Rule.new(sentence)}]
  end
end

class Rule
  attr_reader :product

  def initialize(sentence)
    sentence =~ /Each (\S+) robot costs (\d+) ore( and (\d+) ([^ .]+).?)?/
    @product = $1
    @cost = [[$2.to_i, 'ore']]
    if !$4.nil?
      @cost += [[$4.to_i, $5]]
    end
  end

  def can_apply?(resources)
    @cost.all?{|number, type| resources[type] >= number}
  end

  def apply(resources)
    new_resources = resources.clone
    @cost.each{|number, type| new_resources[type] -= number}
    new_resources
  end
end

def all_ways_to_apply_using_first(rules, resources)
  rule = rules.first
  if rule.can_apply?(resources)
    others = all_ways_to_apply(rules, rule.apply(resources))
    if others.empty?
      [[rule]]
    else
      others.map{|rule_seq| [rule] + rule_seq}
    end
  else
    []
  end
end

def all_ways_to_apply(rules, resources)
  (0...rules.size).map do |i|
    all_ways_to_apply_using_first(rules[i..], resources)
  end.flatten(1) + [[]]
end

def produce_resources(resources, robots)
  new_resources = resources.clone
  robots.each do |robot_type, number|
    new_resources[robot_type] += number
  end
  new_resources
end

def build_robots(resources, robots, rule_seq)
  new_resources, new_robots = resources.clone, robots.clone
  rule_seq.each do |rule|
    new_resources = rule.apply(new_resources)
    new_robots[rule.product] += 1
  end
  [new_resources, new_robots]
end
    
class Node
  include Comparable

  attr_reader :time, :resources, :robots

  def initialize(time, resources, robots)
    @time, @resources, @robots = time, resources, robots
  end

  def to_s = "time = #{@time}, resources = #{@resources}, robots = #{@robots}"

  def next_nodes(rules)
    time = @time + 1
    increased_resources = produce_resources(@resources, @robots)

    all_ways_to_apply(rules, @resources).map do |rule_seq|
      resources, robots = build_robots(increased_resources, @robots, rule_seq)
      Node.new(time, resources, robots)
    end
  end

  def <=>(other)
    [@time, @resources.to_a, @robots.to_a] <=> [other.time, other.resources.to_a, other.robots.to_a]
  end

  def eql?(other)
    [@time, @resources, @robots] == [other.time, other.resources, other.robots]
  end

  def hash = [@time, @resources, @robots].hash
end
