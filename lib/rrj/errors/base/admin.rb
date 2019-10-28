# frozen_string_literal: true

# @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>

module RubyRabbitmqJanus
  # Define all error in gem
  module Errors
    # Define a super class for all errors in RRJ Class
    class BaseRRJAdmin < RRJError
      def initalize(message, level)
        super "[RRJAdmin] #{message}", level
      end
    end

    module RRJAdmin
      # Error for RRJAdmin#admin_endpoint
      class StartTransactionAdmin < RubyRabbitmqJanus::Errors::BaseRRJAdmin
        def initialize(opts)
          super "Transaction admin failed with -- #{opts}", :fatal
        end
      end
    end
  end
end
