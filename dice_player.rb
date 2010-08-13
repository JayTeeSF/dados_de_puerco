require 'array_extensions.rb'
require 'player.rb'

class DicePlayer < Player

  include ClassCounter

  def initialize(options={})
    @roll_history = options[:roll_history] || []

    self.class.count += 1
    options[:name] ||= "Player ##{self.class.count}"

    super(options)
  end

  def roll(dice)
    dice = [dice] unless dice.kind_of?(Array)

    results = []
    dice.each_with_index do |die, idx|
# puts "die.class: #{die.class}; idx.class: #{idx.class}"
      @roll_history[idx] ||= []
      results << die.roll
      @roll_history[idx] << results.last
    end

    results
  end

  def last_roll
    p get_roll(last_roll_idx)
  end

  def score_history
    (0..last_roll_idx).collect do |idx|
      roll_score(idx)
    end
  end

  def roll_history(since_last=0)
    die_idx = -1
    @roll_history.collect do |val|
      die_idx += 1
      @roll_history[die_idx]
    end
  end

  def roll_score(roll_idx=last_roll_idx,score=0)
    get_roll(roll_idx).each do |die_idx, value|
      value ||= 0
      score += value
    end

    score
  end

  private

  def last_roll_idx
    @roll_history[0] ||= []
    ret_val = @roll_history[0].size - 1
    ret_val < 0 ? 0 : ret_val
  end

  def get_roll(idx)
puts "getting roll: #{idx}"
    return [[0, 0]] if @roll_history[0].empty?
    @roll_history[0] ||= []
    die_idx = -1
    @roll_history.collect do |val|
      die_idx += 1
      value = @roll_history[die_idx][idx] || 0
      [ die_idx, value ]
    end
  end

end
