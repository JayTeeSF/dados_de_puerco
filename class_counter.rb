module ClassCounter
  def self.included(base)
    base.class_eval do
      @count = 0
      class << self
        attr_accessor :count
      end
    end
  end
end
