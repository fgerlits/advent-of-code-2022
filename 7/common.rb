class File
  attr_reader :size, :name
  def initialize(size, name)
    @size = size.to_i
    @name = name
  end

  def to_s
    "- #{@name} (file, size=#{@size})"
  end
end

class Directory
  attr_reader :name, :children, :files
  def initialize(name, parent)
    @name = name
    @parent = parent
    @children = []
    @files = []
  end

  def cd(name)
    if name == '..'
      @parent
    else
      @children.find{|child| child.name == name}
    end
  end

  def add_child(name)
    @children << Directory.new(name, self)
  end

  def add_file(size, name)
    @files << File.new(size, name)
  end

  def to_s_lines
    ["- #{@name} (dir)"] +
        (@children.map(&:to_s_lines).flatten + @files.map(&:to_s)).map{|line| '  ' + line}
  end

  def to_s
    to_s_lines.join("\n")
  end

  def size
    @children.map(&:size).sum + @files.map(&:size).sum
  end
end

def parse_input(stream)
  first_line = stream.readline.chomp
  raise unless first_line == "$ cd /"
  current_dir = root_dir = Directory.new('/', nil)

  stream.each do |line|
    case line.chomp
    when /^\$ cd (.+)$/
      current_dir = current_dir.cd($1)
      raise unless !current_dir.nil?
    when /^\$ ls$/
      # no-op
    when /^dir (.+)$/
      current_dir.add_child($1)
    when /^(\d+) (.+)$/
      current_dir.add_file($1, $2)
    end
  end

  root_dir
end

def collect_directories(dir)
  [dir] + dir.children.map{|child| collect_directories(child)}.flatten
end
