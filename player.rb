class Player

  @count = 0
  class << self
    attr_accessor :count
  end

  attr_accessor :score

  def initialize(options={})
    self.class.count += 1
    @name = options[:name] || "Player ##{self.class.count}"
    @score = options[:score] || 0
  end
  
  def to_s
    @name
  end
end
