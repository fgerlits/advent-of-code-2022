require_relative '../util/breadth_first_search'

class Cave
  def initialize(lines)
    @tunnels = Hash.new(Array.new)
    @flow_rate = Hash.new
    lines.each do |line|
      line =~ /Valve ([^ ]+) has flow rate=([0-9]+);.* to valves? (.*)\n/
      current, flow_rate, neighbors = $1, $2, $3
      @flow_rate[current] = flow_rate.to_i
      @tunnels[current] = neighbors.split(', ')
    end
  end

  def flow_at(node)
    @flow_rate[node]
  end

  def edges
    @tunnels.map{|from, neighbors| neighbors.map{|to| [from, to]}}.flatten(1)
  end

  def nodes_with_flow
    @flow_rate.select{|node, rate| rate > 0}.map{|node, rate| node}
  end
end

def graph(cave)
  vertices = ['AA'] + cave.nodes_with_flow
  edges = cave.edges
  vertices.map do |vertex|
    [vertex, breadth_first_search(edges, vertex).select{|v, d| vertices.include?(v)}]
  end.to_h
end


def max_on_vertices(vertices, cave, graph, num_steps)
  vertices.permutation.map do |path|
    path = path.map do |step|
      if step == 'FI'
        ['FI', 'AT', 'TO']
      elsif step == 'KB'
        ['KB', 'NA', 'XX', 'UD', 'YD']
      else
        step
      end
    end.flatten(1)
    flow_on_path(path, cave, graph, num_steps)
  end.max
end

def flow_on_path(path, cave, graph, num_steps)
  time = 0
  current = 'AA'
  total = 0
  path.each do |step|
    switched_on_at = time + graph[current][step] + 1
    time = switched_on_at
    if time >= num_steps
      break
    end
    current = step
    total += (num_steps - switched_on_at) * cave.flow_at(step)
  end
  total
end
