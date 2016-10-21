# frozen_string_literal: true
# :reek:FeatureEnvy

module RubyRabbitmqJanus
  module Errors
    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
    # Define errors to message sending and response to janus
    class JanusError < RRJError
      def initialize(message)
        super "[JANUS] #{message}", :fatal
      end
    end
  end
end
