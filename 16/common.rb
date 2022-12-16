class Cave
  attr_reader :tunnels, :flow_rate, :size

  def initialize(lines)
    @tunnels = Hash.new(Array.new)
    @flow_rate = Hash.new
    lines.each do |line|
      line =~ /Valve ([^ ]+) has flow rate=([0-9]+);.* to valves? (.*)\n/
      current, flow_rate, neighbors = $1, $2, $3
      @flow_rate[current] = flow_rate.to_i
      @tunnels[current] = neighbors.split(', ')
    end
    @size = @flow_rate.size
  end
end

class State
  attr_reader :current, :open_valves

  def initialize(current, open_valves)
    @current = current
    @open_valves = open_valves
  end

  def continuations(cave)
    if @open_valves.size == cave.size
      return []
    end

    cave.tunnels[@current].map do |neighbor|
      [:move, neighbor]
    end +
    if !@open_valves.include?(@current) && cave.flow_rate[@current] != 0
      [[:open]]
    else
      []
    end
  end

  def apply(step)
    if step[0] == :move
      State.new(step[1], @open_valves)
    else
      State.new(@current, @open_valves + [@current])
    end
  end

  def to_s
    "(#{@current} [#{@open_valves.join(', ')}])"
  end
end

def apply(steps)
  steps.inject(State.new(START_NODE, [])){|state, step| state.apply(step)}
end

def value(steps, cave)
  state = State.new(START_NODE, [])
  (1..30).zip(steps).map do |time, step|
    flow = state.open_valves.map{|node| cave.flow_rate[node]}.sum
    if step
      state = state.apply(step)
    end
    flow
  end.sum
end
