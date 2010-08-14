class Utility

  def self.set_option(variable, type, default, &condition)
    result = (variable && variable.respond_to?(:dup) && ! variable.kind_of?(Fixnum)) ? variable.dup : variable
    #puts "result: #{result}"
    result = send(variable) if variable.kind_of?(Symbol) && type != Symbol
    #puts "result2: #{result}"

    return default unless result.kind_of?(type)
    final_condition = true
    final_condition = yield result if block_given?
    #puts "final_condition: #{final_condition}"
    return default unless final_condition

    result
  end

end
