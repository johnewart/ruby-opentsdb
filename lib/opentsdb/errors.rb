module OpenTSDB
  module Errors
    class UnableToConnectError < StandardError
      def to_s
        'Unable to connect or invalid connection data'
      end
    end
  end
end
