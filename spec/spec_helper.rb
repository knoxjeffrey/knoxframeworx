require 'knoxframeworx'
require "rspec"


$LOAD_PATH.unshift File.join(File.dirname(__FILE__), "..", 'lib')



RSpec.configure do |config|

  config.filter_run focus: true
  config.run_all_when_everything_filtered = true
  config.color = true
end