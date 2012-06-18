module OpenTSDB
  module Logging
    
    def self.included(target)
      target.extend ClassMethods
    end
    
    def logger
      self.class.logger
    end
    
    module ClassMethods
      def logger
        OpenTSDB.logger
      end
    end
    
  end
end
