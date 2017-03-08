# frozen_string_literal: true
# @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>

module RubyRabbitmqJanus
  module Errors
    # Define errors to message sending and response to janus
    class Janus < RRJError
      # Initialize a error standard for janus module
      #
      # @param [String] message Text returning in raise
      def initialize(message)
        super "[JANUS]#{message}", :fatal
      end
    end
  end
end

require 'rrj/errors/janus/janus_processus_keepalive'
require 'rrj/errors/janus/janus_message'
require 'rrj/errors/janus/janus_response'
require 'rrj/errors/janus/janus_transaction'
