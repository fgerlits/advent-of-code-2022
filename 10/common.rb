def parse_input(stream)
  stream.map do |line|
    case line
    when /noop/
      [:noop]
    when /addx ([0-9-]+)/
      [:addx, $1.to_i]
    end
  end
end

def execute(program)
  cycle = 1
  x_reg = 1
  x_values = {1 => 1}
  program.each do |instr, arg|
    cycle += 1
    x_values[cycle] = x_reg
    case instr
    when :noop
    when :addx
      x_reg += arg
      cycle += 1
      x_values[cycle] = x_reg
    end
  end
  x_values
end
