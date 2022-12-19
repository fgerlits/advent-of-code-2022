def parse_input(stream)
  stream.map do |line|
    line.chomp =~ /Blueprint (\d+): (.*)/
    [$1.to_i, $2.split('. ').map{|sentence| Rule.new(sentence)}]
  end
end

class Rule
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

def all_ways_to_apply(rules, resources)
  # TODO
end

class Node
  def initialize(time, resources, robots, pending_robots)
    @time, @resources, @robots, @pending_robots = time, resources, robots, pending_robots
  end

  def next_nodes(rules)
    # TODO
  end

  def create_resources
    @robots.each do |robot_type, number|
      @resources[robot_type] += number
    end
  end
end
