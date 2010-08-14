class Player

  @count = 0
  class << self; attr_accessor :count; end

  attr_reader :score

  def initialize(options={})
    Player.count += 1
    # @name = (options[:name]) ? options[:name] : 
    #@score = options[:score] || 0
    @name = Utility.set_option(options[:name], String, "Player ##{Player.count}") { |var| ! var.empty? }
    @score = Utility.set_option(options[:score], Fixnum, 0) { |var| var > 0 }
  end
  
  def to_s
    @name
  end

  private

  def score=(score)
    @score = score
  end

end
