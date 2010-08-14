class Die
  class SideCountException < Exception; end

  attr_accessor :sides
  DEFAULT_NUM_SIDES = 6
  def initialize(sides=DEFAULT_NUM_SIDES)
    @sides = (sides > 0)  ?  sides : raise(SideCountException, "You can't create a die with #{sides} sides; must be > 0")
  end

  def roll
    1 + rand(@sides)
  end

end
