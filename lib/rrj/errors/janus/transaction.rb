# frozen_string_literal: true

module RubyRabbitmqJanus
  module Errors
    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
    #
    # Define an exception for initalizer transaction
    class JanusTransaction < BaseJanus
      # Initialize a error for janus transaction class
      #
      # @param [String] message Text returning in raise
      def initialize(message)
        super "[Transaction]#{message}"
      end
    end

    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
    #
    # Define an exception for running_handle
    class JanusTransactionHandle < JanusTransaction
      # Initialize a error for janus transaction handle class
      #
      # @param [String] message Text returning in raise
      def initialize(message)
        super "[Handle] #{message}"
      end
    end
  end
end
