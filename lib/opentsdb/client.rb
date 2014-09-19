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

    def self.to_command( options )

      timestamp = options[:timestamp].to_i
      metric_name = options[:metric]
      value = options[:value].to_f
      tags = options[:tags].map{|k,v| "#{k}=#{v}"}.join(" ")
      return "put #{metric_name} #{timestamp} #{value} #{tags}"
    end

    def self.build_command( input ) 
      command = ""
      if input.kind_of?(Array)
        input.each do |unit|
          command += to_command( unit ) + "\n"
        end
      else
        command = to_command input
      end
      return command.chomp

    end

    def put(options = {})
      command = self.class.build_command options
      @connection.puts(command)
    end
  end
end
