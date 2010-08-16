require 'spec_helper'

describe Die do
  context "create w/ valid # of sides" do
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

  context "create w/ invalid # of sides" do
    (-100..0).each do |num_sides|
      it "should not create a #{num_sides}-sided die" do
        lambda { d = Die.new(num_sides) }.should raise_error
      end
    end
  end

  context "(re-)assign a # of sides" do
    before(:each) do
      @d = Die.new
    end

    context "a valid #" do
      (1..100).each do |num_sides|
        it "should update a #{Die::DEFAULT_NUM_SIDES}-sided die to be a #{num_sides}-sided die and roll a number from 1 to #{num_sides} (inclusive)" do
          @d.sides.should == Die::DEFAULT_NUM_SIDES
          @d.sides = num_sides  # set
          roll = @d.roll
          roll.should be > 0
          roll.should be <= @d.sides
        end # it-block
      end # do-end
    end # context

    context "an invalid #" do
      (-100..0).each do |num_sides|
        it "should raise an exception" do
          @d.sides.should == Die::DEFAULT_NUM_SIDES
          lambda { @d.sides = num_sides }.should raise_error
        end # it-block
      end # do-end
    end # context
  end # context

end
