class Die
  # Raise this if a die is initialized w/ invalid # of sides
  class SideCountException < Exception; end

  DEFAULT_NUM_SIDES = 6
  attr_accessor :sides

  def initialize(sides=DEFAULT_NUM_SIDES)
    @sides = (sides > 0)  ?  sides : raise(SideCountException, "You can't create a die with #{sides} sides; must be > 0")
  end

  def roll
    1 + rand(@sides)
  end

end
