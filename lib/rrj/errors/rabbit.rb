# frozen_string_literal: true

module RubyRabbitmqJanus
  module Errors
    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
    # Define errors if connection to rabbitmq is failed
    class ConnectionRabbitmqFailed < RRJError
      # Initialize a error for rabbit module. It's a fatal error
      # @param [String] message Text returning in raise
      def initialize(message)
        super message, :fatal
      end
    end
  end
end
