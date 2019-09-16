require 'socket'
require 'opentsdb/logging'

module OpenTSDB
  class Client
    include Logging

    attr_reader :connection

    def initialize(options = {})
      hostname    = options[:hostname] || 'localhost'
      port        = options[:port] || 4242
      @connection = TCPSocket.new(hostname, port)
    rescue
      raise Errors::UnableToConnectError
    end

    def to_command(options)
      if !options.key?(:tags) || !options[:tags].is_a?(Hash) || options[:tags].empty?
        fail OpenTSDB::Errors::InvalidTagsError
      end

      timestamp   = options[:timestamp].to_i
      metric_name = options[:metric]
      value       = options[:value].to_f
      tags        = options[:tags].map { |k, v| "#{k}=#{v}" }.join(' ')

      "put #{metric_name} #{timestamp} #{value} #{tags}"
    end

    def build_command(input)
      if input.is_a?(Array)
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
