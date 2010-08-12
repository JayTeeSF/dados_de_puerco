require 'rubygems'
require 'metric_fu'
require 'active_support'

      MetricFu::Configuration.run do |config|
      config.metrics = [:churn, :saikuro, :flog, :flay]
      config.graphs = [:flog, :flay, :stats]
      config.saikuro  = { :output_directory => 'tmp/metric_fu/saikuro', 
                          :input_directory => ['.'],
                          :cyclo => "",
                          :filter_cyclo => "0",
                          :warn_cyclo => "5",
                          :error_cyclo => "7",
                          :formater => "text"}
      end
