# This file is copied to ~/spec when you run 'ruby script/generate rspec'
# from the project root directory.
require 'spec/autorun'

# require all the code:
Dir[File.expand_path(File.join(File.dirname(__FILE__),'..','**','*.rb'))].each {|f| require f}

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
#Dir[File.expand_path(File.join(File.dirname(__FILE__),'support','**','*.rb'))].each {|f| require f}

Spec::Runner.configure do |config|

  # == Mock Framework
  #
  # RSpec uses it's own mocking framework by default. If you prefer to
  # use mocha, flexmock or RR, uncomment the appropriate line:
  #
  #config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
  #
  # == Notes
  #
  
end
