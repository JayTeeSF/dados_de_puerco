# require 'class_counter.rb'
Dir[File.expand_path(File.join(File.dirname(__FILE__),'..','lib', 'class_counter.rb'))].each {|f| require f}
class Player

  include ClassCounter

  attr_reader :score

  def initialize(options={})
    @name = options[:name]
    unless @name
      self.class.count += 1
      @name = "Player ##{self.class.count}"
    end
    @score = options[:score] || 0
  end
  
  def to_s
    @name
  end

  private

  def score=(score)
    @score = score
  end

end
