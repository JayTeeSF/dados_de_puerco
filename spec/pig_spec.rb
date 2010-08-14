require 'spec_helper'

describe Pig do
  before(:each) do
    @params = {}
    @action = lambda { @g = Pig.new(@params)  }
  end

  context "When default params (except silent)" do
    before(:each) do
      @params = {:silent => true}
    end

    it "should have default settings" do
      @action.call
      Pig::GOAL.should == 100
      @g.silent.should be true
      @g.craps?.should be false
      @g.current_player.to_s.gsub(/\d+/,'').should == DicePlayer.new.to_s.gsub(/\d+/,'')
      @g.craps.should == 1
      @g.players.size.should == 2
      @g.dice.size.should == 1
      @g.dice.first.sides.should == 6
    end

    it "should be playable" do
      @action.call
      first_player = @g.current_player.dup
      roll = @g.roll
      roll.should be > 0
      roll.should be <= @g.dice.first.sides
      @g.current_player.last_roll_score.should be roll
      @g.craps?.should be @g.craps == roll

      @g.pass
      @g.current_player.should_not be first_player
    end

  end
end
