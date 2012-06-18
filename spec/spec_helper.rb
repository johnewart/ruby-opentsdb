require 'simplecov'

SimpleCov.start do
  add_filter "/spec/"
  merge_timeout 3600
end

$:.unshift(File.expand_path('../../lib', __FILE__))
require 'opentsdb'

OpenTSDB.logger = Logger.new(STDERR)
OpenTSDB.logger.level = Logger::INFO

RSpec.configure do |config|
  config.mock_with :rspec
end
