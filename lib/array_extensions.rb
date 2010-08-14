Array.class_eval do
  def sum &block
    if block_given?
      (self.collect block).sum_without_block
    else
      sum_without_block
    end
  end

  def sum_without_block
    sum = 0
    self.each do |val|
      sum += val
    end
    sum
  end
end
