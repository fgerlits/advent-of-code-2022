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
end
