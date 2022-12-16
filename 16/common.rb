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
