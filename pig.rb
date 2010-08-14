# IRB.quiet; require 'pig.rb'; g = Pig.new(:player1 => "me", :player2 => "you")
# pm g

#require 'array_extensions.rb'
#require 'die.rb'
#require 'dice_player.rb'
Dir[File.expand_path(File.join(File.dirname(__FILE__),'lib', '*.rb'))].each {|f| require f}
Dir[File.expand_path(File.join(File.dirname(__FILE__),'app', '*.rb'))].each {|f| require f}

class Pig

  attr_reader :craps
  # before_filter :return_if_done, :only => [:inc, :next_turn, :roll]
  GOAL = 100

  def initialize(options={})
    @die = Die.new
    # p options[:player1]
    @players = [DicePlayer.new(:name => options[:player1]), DicePlayer.new(:name => options[:player2])]
    @turn = 0
    @done = false
    @craps = options[:craps] || 1
    announce_turn
  end

  def craps?(value=current_player.last_roll_score)
    # puts "roll-value: #{value}"
    value == craps
  end

  def pass
    @crapped_out = false
    next_turn
    announce_turn
  end

  def roll
    value = 0
    if @done
      puts "Game over ...no more roll'in"
      return value
    end

    if @crapped_out
      puts "You crapped-out; 'pass' to the next player."
      return value
    end

    value = current_player.roll(@die).sum
    print "#{current_player} rolled a #{value}"

    if craps?(value)
      current_player.send(:"score=",0)
      @crapped_out = true
    else
      current_player.send(:"score=",current_player.score + value)
    end
    puts " ...and now has a total of #{current_player.score} points"

    announce_winner if current_player.score > GOAL
    return value
  end

  def score
    puts "#{current_player} vs. #{next_player}: #{current_player.score}:#{next_player.score}"
  end

  def current_player
    @players[@turn]
  end

  def help
    puts "do stuff like roll, pass or score"
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
