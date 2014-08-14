class String
  def number?
    self.to_i.to_s == self
  end
end

# A FORTH interpreter for people on a budget..
class Stacker::Interpreter

  attr_reader :stack, :words

  def initialize
    @stack   = []
    @words   = Hash.new(->{ raise 'WORD NOT FOUND'}).merge(std_lib)
  end

  def std_lib
    {
    "=".to_sym=> ->(){ stack.push((stack.pop == stack.pop).to_s.to_sym) },
    # TODO: Use 0 / 1 for truthiness
    :>     => ->(){ push((pop > pop).to_s.to_sym) },
    :<     => ->(){ push((pop < pop).to_s.to_sym) },
    add:      ->(){ push(pop + pop) },
    subtract: ->(){ push(pop - pop) },
    multiply: ->(){ push(pop * pop) },
    divide:   ->(){ push(pop / pop) },
    mod:      ->(){ push(pop % pop) },
    false:    ->(){ push(0) },
    true:     ->(){ push(1) },
    rot:      ->(){ stack.rotate! },
    drop:     ->(){ pop },
    swap:     ->(){ one = stack.pop; two = stack.pop; stack.push(one); stack.push(two) },
    dup:      ->(){ dbl = stack.pop; 2.times{ stack.push(dbl) } }
    }
  end

  def execute(args = [])
    args.each{|arg| exec(arg)}
    @stack
  end

  # Interpret a single command.
  def exec(arg)
      arg.number? ? stack.push(arg.to_i) : @words[arg.downcase.to_sym][]
  end

  def pop
    stack.pop
  end

  def push(arg)
    stack.push arg
  end

  def swp
    exec('swap')
  end

end
