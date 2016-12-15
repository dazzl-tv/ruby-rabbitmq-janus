# frozen_string_literal: true

module RubyRabbitmqJanus
  module Errors
    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>

    # Define errors to message sending and response to janus
    class JanusError < RRJError
      # Initialize a error standard for janus module
      # @param [String] message Text returning in raise
      def initialize(message)
        super "[JANUS]#{message}", :fatal
      end
    end
  end
end
