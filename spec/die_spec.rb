require 'spec_helper'

describe Die do
  context "valid # of sides" do
    (1..100).each do |num_sides|
      it "should create a #{num_sides}-sided die and roll a number from 1 to #{num_sides} (inclusive)" do
        d = Die.new(num_sides)
        d.sides.should == num_sides
        roll = d.roll
        roll.should be > 0
        roll.should be <= d.sides
      end
    end
  end

  context "invalid # of sides" do
    (-100..0).each do |num_sides|
      it "should not create a #{num_sides}-sided die" do
        lambda { d = Die.new(num_sides) }.should raise_error
      end
    end
  end

end
