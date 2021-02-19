# frozen_string_literal: true

# @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>

module RubyRabbitmqJanus
  # Define all error in gem
  module Errors
    # Define a super class for all errors in RRJ Class
    class BaseRRJ < RRJError
      def initalize(message, level)
        super "[RRJ] #{message}", level
      end
    end

    module RRJ
      # Error for RRJ#initialize
      class InstanciateGem < RubyRabbitmqJanus::Errors::BaseRRJ
        def initialize(message)
          super "Gem is not instanciate correctly : #{message}", :fatal
        end
      end

      # Error for RRJ#session_endpoint_public
      class StartTransaction < RubyRabbitmqJanus::Errors::BaseRRJ
        def initialize(exclu, opts)
          super "Transaction failed with -- #{opts} in queue #{exclu}", :fatal
        end
      end

      # Error for RRJ#session_endpoint_public_handle
      class StartTransactionHandle < RubyRabbitmqJanus::Errors::BaseRRJ
        def initialize(exclu, opts)
          super "Transaction handle failed with -- #{opts} in queue #{exclu}",
                :fatal
        end
      end

      # Error for RRJ#cleanup_connection
      class CleanupConnection < RubyRabbitmqJanus::Errors::BaseRRJ
        def initialize
          super 'Error for cleanup Janus Instances', :warn
        end
      end
    end
  end
end
