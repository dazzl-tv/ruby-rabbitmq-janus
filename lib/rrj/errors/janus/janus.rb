# frozen_string_literal: true

# @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>

module RubyRabbitmqJanus
  module Errors
    # Define errors to message sending and response to janus
    class BaseJanus < RRJError
      # Initialize a error standard for janus module
      #
      # @param [String] message Text returning in raise
      def initialize(message, level)
        super "[JANUS]#{message}", level
      end
    end
  end
end

require 'rrj/errors/janus/messages/message'
require 'rrj/errors/janus/messages/admin'
require 'rrj/errors/janus/messages/standard'

require 'rrj/errors/janus/responses/response'
require 'rrj/errors/janus/responses/admin'
require 'rrj/errors/janus/responses/event'
require 'rrj/errors/janus/responses/standard'

require 'rrj/errors/janus/transactions/transaction'
require 'rrj/errors/janus/transactions/admin'
require 'rrj/errors/janus/transactions/handle'
require 'rrj/errors/janus/transactions/session'
