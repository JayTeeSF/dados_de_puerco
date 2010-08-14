class App

  def self.relative_require(path_elements)
    self.relative_files(path_elements).each {|f| require f }
  end

  def self.relative_files(path_elements)
    current_dir = File.dirname(__FILE__)
    path = File.join( [ current_dir ] + path_elements )
    Dir[ File.expand_path( path ) ]
  end

  def self.require_list(requirements)
    requirements.each do |requirement|
      self.relative_require(requirement)
    end
  end

  App.require_list([
                       [ '..', 'lib', '*.rb' ],
                       [ '..', 'app', 'die.rb' ],
                       [ '..', 'app', 'player.rb' ],
                       [ '..', 'app', 'dice_player.rb' ],
                       [ '..', 'pig.rb' ]
  ])
end

