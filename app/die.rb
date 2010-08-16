class Die
  # Raise this if a die is initialized w/ invalid # of sides
  class SideCountException < Exception; end

  DEFAULT_NUM_SIDES = 6
  attr_reader :sides

  def initialize(sides=DEFAULT_NUM_SIDES)
    self.sides=(sides)
  end

  def sides=(val)
    @sides = (val.to_i > 0)  ?  val.to_i : raise(SideCountException, "You can't create a #{val.inspect}-sided die; must be > 0")
  end

  def roll
    1 + rand(@sides)
  end

end
