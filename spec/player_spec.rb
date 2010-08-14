require 'spec_helper'

describe Player do
  before(:each) do
    @params = {}
    @action = lambda { @p = Player.new(@params) }
  end

  context "When valid params" do
    context "default(s)" do
      it "should have a default name and score" do
        @action.call
        @p.score.should be 0
        @p.to_s.should == "Player #1"

        next_player = Player.new
        next_player.to_s.should_not == @p.to_s
        next_player.to_s.should match /Player #\d+/
      end
    end
  
    context "option(s)" do
      before(:each) do
        @name = "foo"
        @score = 100
        @params = {:name => @name, :score => @score}
      end

      it "should have a valid name and score" do
        @action.call
        @p.score.should == @score
        @p.to_s.should == @name

        next_player = Player.new
        next_player.to_s.should_not == @p.to_s
        next_player.to_s.should match /Player #\d+/
      end
    end
  end

end
