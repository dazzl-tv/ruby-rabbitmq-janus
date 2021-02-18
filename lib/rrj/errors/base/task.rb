# frozen_string_literal: true

# @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>

module RubyRabbitmqJanus
  # Define all error in gem
  module Errors
    # Define a super class for all errors in RRJ Class
    class BaseRRJTask < RRJError
      def initialize(message, level = :fatal)
        super "[RRJAdmin]#{message}", level
      end
    end

    module RRJTask
      # Error for RRJTask#initialize
      class Initialize < BaseRRJTask
        def initialize
          super '[Task] Error in initializer'
        end
      end

      # Error for RRJTask#handle_endpoint_public
      class StartTransactionHandle < BaseRRJTask
        def initialize(exclu, opts)
          super '[Task] Transaction admin failed with -- ' \
            "#{opts} in queue #{exclu}", :fatal
        end
      end
    end
  end
end
