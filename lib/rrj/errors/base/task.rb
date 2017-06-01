# frozen_string_literal: true

# @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>

module RubyRabbitmqJanus
  # Define all error in gem
  module Errors
    # Define a super class for all errors in RRJ Class
    class BaseRRJTask < RRJError
      def initalize(message, level)
        super "[RRJAdmin] #{message}", level
      end
    end

    module RRJTask
      # Error for RRJTask#start_transaction_handle
      class StartTransactionHandle < RubyRabbitmqJanus::Errors::BaseRRJTask
        def initialize(exclu, opts)
          super "Transaction admin failed with -- #{opts} in queue #{exclu}",
                :fatal
        end
      end
    end
  end
end
