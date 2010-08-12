# IRB.quiet; require 'pig.rb'; g = Pig.new
# pm g

require 'die.rb'
require 'player.rb'

class Pig

  # before_filter :return_if_done, :only => [:inc, :next_turn, :roll]
  GOAL = 100

  def initialize(options={})
    @die = Die.new
    # p options[:player1]
    @players = [Player.new(:name => options[:player1]), Player.new(:name => options[:player2])]
    @turn = 0
    @done = false
    announce_turn
  end

  def pass
    @crapped_out = false
    next_turn
    announce_turn
  end

  def roll
    return if @done
    return if @crapped_out

    value = @die.roll
    print "#{current_player} rolled a #{value}"

    if 1 == value
      current_player.score = 0
    else
      current_player.score += value
    end
    puts " ...and now has a total of #{current_player.score} points"

    @crapped_out = true if 0 == current_player.score
    announce_winner if current_player.score > GOAL
  end

  def check_score
    puts "#{current_player} vs. #{next_player}: #{current_player.score}:#{next_player.score}"
  end

  def current_player
    @players[@turn]
  end

  def help
    puts "do stuff like roll, pass or check_score"
  end

  private

  def announce_turn
    puts "It's now #{current_player}'s turn"
  end

  def next_player
    @players[inc]
  end

  def next_turn
    return if @done
    @turn = inc
  end

  def inc
    return if @done
    (@turn + 1) % @players.count
  end

  def announce_winner
    puts "Congratulations, player ##{@turn + 1} wins (#{current_player.score}:#{next_player.score})"
    @done = true
  end

end
