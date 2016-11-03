module OpenTSDB
  module Errors
    class UnableToConnectError < StandardError
      def to_s
        'Unable to connect or invalid connection data'
      end
    end

    class InvalidTagsError < StandardError
      def to_s
        'The tags you provided are invalid. Note that you need at least one tag to proceed.'
      end
    end
  end
end
