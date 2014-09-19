require 'socket'
require 'opentsdb/logging'

module OpenTSDB
  class Client
    include Logging

    attr_reader :connection

    def initialize(options = {})
      begin
        hostname = options[:hostname] || 'localhost'
        port = options[:port] || 4242
        @connection = TCPSocket.new(hostname, port)
      rescue
        raise "Unable to connect or invalid connection data"
      end
    end

    def to_command( options )
      timestamp = options[:timestamp].to_i
      metric_name = options[:metric]
      value = options[:value].to_f
      tags = options[:tags].map{|k,v| "#{k}=#{v}"}.join(" ")
      "put #{metric_name} #{timestamp} #{value} #{tags}"
    end

    def build_command(input) 
      if input.kind_of?(Array)
        input.collect { |unit| to_command(unit) }.join("\n")
      else
        to_command(input)
      end.chomp
    end

    def put(options = {})
      @connection.puts(build_command(options))
    end
  end
end
