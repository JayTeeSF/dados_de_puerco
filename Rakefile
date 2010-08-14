require 'rubygems'
require 'metric_fu'
require 'active_support'

      MetricFu::Configuration.run do |config|
      config.metrics = [:churn, :saikuro, :flog, :flay, :reek, :roodi]
      config.graphs = [:flog, :flay, :stats]
      config.saikuro  = { :output_directory => 'tmp/metric_fu/saikuro', 
                          :input_directory => ['app', 'lib'],
                          :cyclo => "",
                          :filter_cyclo => "0",
                          :warn_cyclo => "5",
                          :error_cyclo => "7",
                          :formater => "text"}
      config.rcov = {
        :test_files => ['spec/**/*_spec.rb'],
        :rcov_opts => ["--sort coverage", 
                                           "--no-html", 
                                           "--text-coverage",
                                           "--no-color",
                                           "--profile",
                                           "--exclude spec"],
        :external => nil
      }
      config.flay ={:dirs_to_flay => ['app', 'lib'],
                          :minimum_score => 100,
                          :filetypes => ['rb'] }

      config.flog = { :dirs_to_flog => ['app', 'lib'] }
      config.reek = { :dirs_to_reek => ['app', 'lib'] }
      config.roodi = { :dirs_to_roodi => ['app', 'lib'] }
      end
