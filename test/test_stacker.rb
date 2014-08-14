require 'test_helper'
class StackerInterpreterTest < Minitest::Test

  def interpreter
    @i ||= Stacker::Interpreter.new
  end

  def test_add
    interpreter.execute %w[
      2
      3
      ADD
    ]
    assert_equal interpreter.stack, [5]
  end

  def test_subtract
    interpreter.execute %w[
      1
      2
      SUBTRACT
    ]
    assert_equal interpreter.stack, [-1]
  end
  
  def test_multiply
    interpreter.execute %w[
      3
      10
      MULTIPLY
    ]
    assert_equal interpreter.stack, [30]
  end

  def test_divide
    interpreter.execute %w[
      6
      2
      DIVIDE
      ]
    assert_equal interpreter.stack, [3]
  end
  
  def test_mod
    interpreter.execute %w[
      4
      3
      MOD
      15
      3
      MOD
    ]
    
    assert_equal interpreter.stack, [1,0]
  end
  
  def test_less_than
    interpreter.execute %w[
      3
      10
      <
      5
      4
      <
    ]    
    assert_equal interpreter.stack, [:true, :false]
  end
  
  def test_greater_than
    interpreter.execute %w[
      3
      10
      >
      5
      4
      >
    ]
    assert_equal interpreter.stack, [:false, :true]
  end

  def test_equal
    interpreter.execute %w[
      1
      1
      =
      1
      2
      =
    ]    
    assert_equal interpreter.stack, [:true, :false]
  end
  
  # it "implements the IF command" do
  #   interpreter.execute %w[
  #     :true
  #     IF
  #     1
  #     2
  #     ADD
  #     ELSE
  #     5
  #     THEN
  #     2
  #     5
  #     MULTIPLY
  #   ]
  #   interpreter.stack.must_equal([3, 10])
  # end
  
  # it "implements the IF command in nesting" do
  #   interpreter.execute %w[ 
  #      :true
  #      IF
  #      :false
  #      IF
  #      1
  #      ELSE
  #      2
  #      THEN
  #      3
  #      ELSE
  #      :true
  #      IF
  #      4
  #      ELSE
  #      5
  #      THEN
  #      6
  #      THEN
  #      7
  #    ]

  #   interpreter.stack.must_equal([2,3,7])
  # end
  
  # it "implements the IF command in another 2-level nesting" do
  #   interpreter.execute %w[
  #     :false
  #     IF
  #     0
  #     :false
  #     IF
  #     1
  #     2
  #     ELSE
  #     3
  #     2
  #     2
  #     ADD
  #     THEN
  #     5
  #     2
  #     3
  #     MULTIPLY
  #     ELSE
  #     3
  #     4
  #     ADD
  #     7
  #     8
  #     <
  #     IF
  #     2
  #     4
  #     MULTIPLY
  #     3
  #     3
  #     MULTIPLY
  #     ELSE
  #     10
  #     11
  #     THEN
  #     12
  #     13
  #     THEN
  #     14
  #     15
  #   ]
    
  #   interpreter.stack.must_equal([7,8,9,12,13,14,15])
  # end

  # it "implements the IF command in 3-level nesting" do
  #   interpreter.execute %w[
  #     :true
  #     IF
  #     :false
  #       IF
  #       :false
  #         IF
  #         1
  #         ELSE
  #         2
  #         THEN
  #         3
  #       ELSE
  #       :true
  #         IF
  #         4
  #         ELSE
  #         5
  #         THEN
  #         6
  #       THEN
  #       7
  #     ELSE
  #     :false
  #       IF
  #       :true
  #         IF
  #         8
  #         ELSE
  #         9
  #         THEN
  #         10
  #       ELSE
  #       :true
  #         IF
  #         11
  #         ELSE
  #         12
  #         THEN
  #         13
  #       THEN
  #       14
  #     THEN
  #     15
  #     ]
  #   interpreter.stack.must_equal([4,6,7,15])
  # end

  # it "implements TIMES command" do
  #   interpreter.execute %w[
  #     5
  #     3
  #     TIMES
  #     1
  #     ADD
  #     /TIMES
  #   ]

  #   interpreter.stack.must_equal([8])
  # end

  # it "implements TIMES inside of IF command" do
  #   interpreter.execute %w[
  #     :true
  #     IF
  #     5
  #     3
  #     TIMES
  #     2
  #     ADD
  #     /TIMES
  #     ELSE
  #     2
  #     4
  #     TIMES
  #     2
  #     MULTIPLY
  #     /TIMES
  #     THEN
  #     3
  #     5
  #     TIMES
  #     2
  #     ADD
  #     /TIMES
  #     ADD
  #   ]

  #   interpreter.stack.must_equal([24])
  # end
  
  # it "implements IF inside of TIMES command" do
  #   interpreter.execute %w[
  #     5
  #     3
  #     TIMES
  #     :true
  #     IF
  #     1
  #     ADD
  #     ELSE
  #     2
  #     ADD
  #     THEN
  #     3
  #     ADD
  #     /TIMES
  #   ]


  #   interpreter.stack.must_equal([17])
  # end

  # it "implements PROCEDURE command" do
  #   interpreter.execute %w[
  #     PROCEDURE\ DOUBLE
  #     2
  #     MULTIPLY
  #     /PROCEDURE
  #     100
  #     DOUBLE
  #     DOUBLE
  #   ]

  #   interpreter.stack.must_equal([400])
  # end
  
  def test_dup
    interpreter.execute %w[
      1
      2
      DUP
    ]
    assert_equal interpreter.stack, [1,2,2]
  end

  def test_swap
    interpreter.execute %w[
      1
      2
      SWAP
    ]
    assert_equal interpreter.stack, [2,1]
  end
  
  def test_drop
    interpreter.execute %w[
      1
      2
      DROP
    ]
    
    assert_equal interpreter.stack, [1]
  end
  
  def test_rot
    what =  %w[
      1
      2
      3
      ROT
    ]
    interpreter.execute what
    # The original implementation of ROT was possible, but I want to do it the
    # "correct" way and rotate the whole stack.
    assert_equal interpreter.stack, [2, 3, 1]
  end

  def test_symbols
    skip 'nahhh. Too lame.'
    interpreter.execute %w[
      :foo
      :bar
      :baz
    ]
    interpreter.stack.must_equal([:foo,:bar,:baz])
  end  
end
