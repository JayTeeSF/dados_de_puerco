#irb # IRB.quiet; require './config/app.rb'; g = Pig.new(:player1 => "me", :player2 => "you", :num_players => 3)
# pm g
# go fast: 3.times { g.roll }; g.print_score; g.pass
# cheat:
# (1) increase die-sides: g.dice.first.sides=20; ...; g.dice.first.sides=6
# (2) add extra dice: g.dice << Die.new; g.dice << Die.new
#     puts g.dice.size => 3
#     g.current_player.last_roll.inspect # => # [[0, 5], [1, 1], [2, 3]]
#     puts g.current_player.score_history # => 9
#
#
#require 'array_extensions.rb' #require 'die.rb' #require 'dice_player.rb'

class Pig

  attr_accessor :silent
  attr_reader :craps, :players, :dice

  GOAL = 100

  # Options: 
  #   :silent => true/false (typically false)
  #   :craps => some # (typically 1)
  #   :num_dice => some # (typically 1)
  #   :die_sides => some # (typically 6)
  #   :num_players => some # (typically 2)
  #   :player1 => player1's name
  #   :player2 => player2's name
  #   ...
  #   :playerN => playerN's name
  #
  def initialize(options={})
    @silent = !! options[:silent]
    die_sides = options[:die_sides] || 6
    @dice = []
    num_dice = Utility.set_option(options[:num_dice].to_i, Fixnum, 1) { |var| var > 0 }
    num_dice.times { @dice << Die.new(die_sides) }

    num_players = Utility.set_option(options[:num_players].to_i, Fixnum, 2) { |var| var > 0 }
    @players = []

    (1..num_players).each do |idx|
      @players << DicePlayer.new(:name => options[:"player#{idx}"])
    end
    
    @turn = 0
    @done = false
    # @craps = (options[:craps] && options[:craps] > 0) ? options[:craps] : 1
    @craps = Utility.set_option(options[:craps].to_i, Fixnum, 1) { |var| var > 0 }
    announce_turn
  end

  def craps?(value=current_player.last_roll_score)
    # puts "roll-value: #{value}" unless @silent unless @silent
    value == craps
  end

  def pass
    return if @done
    @crapped_out = false
    next_turn
    announce_turn
  end

  def roll
    value = 0
    if @done
      puts "Game over ...no more roll'in" unless @silent
      return value
    end

    if @crapped_out
      puts "You crapped-out; 'pass' to the next player." unless @silent
      return value
    end

    value = current_player.roll(@dice).sum
    print "#{current_player} rolled a #{value}" unless @silent

    if craps?(value)
      current_player.send(:"score=",0)
      @crapped_out = true
    else
      current_player.send(:"score=",current_player.score + value)
    end
    puts " ...and now has a total of #{current_player.score} points" unless @silent

    announce_winner if current_player.score > GOAL
    return value
  end

  def print_score
    score.each do |player, score|
      puts "#{player}: #{score}" unless @silent
    end
  end

  def current_player
    @players[@turn]
  end

  def help
    puts "do stuff like roll, pass or print_score" unless @silent
  end

  private

  def score
    #puts "#{current_player} vs. #{next_player}: #{current_player.score}:#{next_player.score}" unless @silent
    @players.collect do |player|
      [player, player.score]
    end
  end

  def announce_turn
    puts "It's now #{current_player}'s turn" unless @silent
    current_player
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
    puts "Congratulations, #{current_player} wins" unless @silent
    @done = true
    current_player
  end

  # move this method to a module (for re-use, elsewhere)
  #def set_option(variable, type, default, &condition)
    #result = (variable && variable.respond_to?(:dup) && ! variable.kind_of?(Fixnum)) ? variable.dup : variable
    ##puts "result: #{result}"
    #result = send(variable) if variable.kind_of?(Symbol) && type != Symbol
    ##puts "result2: #{result}"
#
    #return default unless result.kind_of?(type)
    #final_condition = true
    #final_condition = yield result if block_given?
    ##puts "final_condition: #{final_condition}"
    #return default unless final_condition
#
    #result
  #end

end
