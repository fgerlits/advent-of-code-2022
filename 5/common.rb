class Move
  def initialize(line)
    line =~ /move (\d+) from (\d+) to (\d+)/
    @count, @from, @to = [$1, $2, $3].map(&:to_i)
    raise unless [@count, @from, @to].all?{|n| n >= 1}
    @from -= 1
    @to -= 1
  end

  def apply(stacks)
    @count.times do
      crate = stacks[@from].pop
      stacks[@to].push(crate)
    end
  end

  def apply2(stacks)
    crates = stacks[@from].pop(@count)
    crates.each do |crate|
      stacks[@to].push(crate)
    end
  end
end

def parse_input(stream)
  crates, moves = stream.readlines.map(&:chomp).slice_after('').to_a
  stacks = crates[0...-1]
      .map{|line| line.each_char.to_a}
      .transpose.select{|row| row[-1] =~ /\d+/}
      .map{|row| row.select{|elt| elt =~ /[A-Z]+/}.reverse}
  moves = moves.map{|line| Move.new(line)}
  [stacks, moves]
end

def top_crates_of(stacks)
  stacks.map{|stack| stack[-1]}.join
end
