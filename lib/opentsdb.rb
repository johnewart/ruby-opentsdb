# == OpenTSDB Initialization
#

require 'logger'

module OpenTSDB
  class << self
    attr_writer :logger
    def logger
      @logger ||= Logger.new(STDOUT)
    end
  end
end

require 'opentsdb/client'
