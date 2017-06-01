# frozen_string_literal: true

# @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>

module RubyRabbitmqJanus
  module Errors
    # Define errors to message sending and response to janus
    class BaseJanus < RRJError
      # Initialize a error standard for janus module
      #
      # @param [String] message Text returning in raise
      def initialize(message)
        super "[JANUS]#{message}", :fatal
      end
    end
  end
end

require 'rrj/errors/janus/concurency'
require 'rrj/errors/janus/keepalive'
require 'rrj/errors/janus/event'

require 'rrj/errors/janus/message'
require 'rrj/errors/janus/response'

require 'rrj/errors/janus/transaction'
