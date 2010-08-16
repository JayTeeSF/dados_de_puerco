# require 'app/die.rb'; require 'lib/utility.rb'; require 'app/trick_die.rb'; t = TrickDie.new(383)
# require 'app/die.rb'; require 'lib/utility.rb'; require 'app/trick_die.rb'; t = TrickDie.new(383, 6)
# TrickDie::BigRollaException: A 6-sided die can't roll a 383 -- not even if it's a trick-die

class TrickDie < Die

  # Raise this if a trick-die is configured to return a result larger than the # of sides on the die
  class BigRollaException < Exception; end

  attr_reader :roll

  def initialize(roll=1, sides=nil)
    self.roll = roll
    super(sides || @roll)
  end

  def roll=(val)
    @roll = Utility.set_option(val, Fixnum, nil) { |var| var > 0 }
    valid_after_set
  end

  def sides=(val)
    super(val)
    valid_after_set
  end

  private

  def valid_after_set
    if @roll.nil? || (@sides && @sides < @roll)
      raise(BigRollaException,"A #{@sides.inspect}-sided die can't roll a #{@roll.inspect} -- not even if it's a trick-die")
    end
  end
end
