require 'opentsdb/logging'

module OpenTSDB
  class Client
    include Logging

    attr_reader :connection

    def initialize(options = {})
      @connection = {}
    end

    def put(options = {})
      timestamp = options[:timestamp].to_i
      metric_name = options[:metric]
      value = options[:value].to_f
      tags = options[:tags].map{|k,v| "#{k}=#{v}"}.join(" ")
      @connection.puts("put #{metric_name} #{timestamp} #{value} #{tags}")
    end
  end
end
