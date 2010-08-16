require 'spec_helper'

describe Player do
  before(:each) do
    @params = {}
    Player.count = 0
    @action = lambda do
      @first_player = Player.new(@params)
      @second_player = Player.new
    end
  end

  context "When valid params" do
    context "default(s)" do
      it "should have a default name and score" do
        @action.call
        @first_player.score.should == 0
        @first_player.to_s.should == "Player #1"

        @second_player.to_s.should_not == @first_player.to_s
        @second_player.to_s.should == 'Player #2'
        @second_player.score.should == 0
      end
    end
  
    context "option(s)" do
      before(:each) do
        @name = "foo"
        @score = 100
        @params = {:name => @name, :score => @score}
      end

      it "should have a valid name and score followed by defaults" do
        @action.call
        @first_player.score.should == @score
        @first_player.to_s.should == @name

        @second_player.to_s.should_not == @first_player.to_s
        @second_player.to_s.should == 'Player #2'
        @second_player.score.should == 0
      end
    end
  end

end
