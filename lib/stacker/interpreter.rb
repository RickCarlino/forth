class String
  def is_integer?
    self.to_i.to_s == self
  end
end

# A FORTH interpreter for people on a budget..
class Stacker::Interpreter

  attr_reader :stack, :words

  def initialize
    @stack = []
    @words = Hash.new(->{ raise 'WORD NOT FOUND'})
    @words.merge!({
    add:      ->(){ stack.push(stack.pop + stack.pop) },
    subtract: ->(){ one = stack.pop; two = stack.pop; stack.push(two - one) },
    multiply: ->(){ stack.push(stack.pop * stack.pop) },
    divide:   ->(){ one = stack.pop; two = stack.pop; stack.push(two / one) },
    mod:      ->(){ one = stack.pop; two = stack.pop; stack.push(two % one) },
    :> =>     ->(){ one = stack.pop; two = stack.pop; stack.push((two > one).to_s.to_sym) },
    :< =>     ->(){ one = stack.pop; two = stack.pop; stack.push((two < one).to_s.to_sym) },
"=".to_sym => ->(){ stack.push((stack.pop == stack.pop).to_s.to_sym) },
    false:    ->(){ stack.push(:false)},
    true:     ->(){ stack.push(:true)}
    })
  end

  def execute(args = [])
    args.each do |arg|
      interpret(arg)
    end
    return @stack
  end

  def interpret(arg)
    if arg.is_integer?
      stack.push(arg.to_i)
    else
      arg = arg.gsub(':', '').downcase.to_sym
      @words[arg][]
    end
  end

  def inspect
    self.stack
  end

end
