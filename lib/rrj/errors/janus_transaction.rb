# frozen_string_literal: true

module RubyRabbitmqJanus
  module Errors
    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
    # Define errors to message sending and response to janus
    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
    # Define an exception for initaliser transaction
    class JanusTransaction < JanusError
      def initialize(message)
        super "[Transaction] Error initialize : #{message}"
      end
    end

    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
    # Define an exception for running_handle
    class JanusTransactionHandle
      def initialize(message)
        super "[Transaction] Error handle #{message}"
      end
    end

    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
    # Define an exception for sending_message
    class JanusTransactionPost < JanusError
      def initialize(message)
        super "[Transaction] Error sending message : #{message}"
      end
    end
  end
end
