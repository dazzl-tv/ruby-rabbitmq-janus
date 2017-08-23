# frozen_string_literal: true

module RubyRabbitmqJanus
  # Define all error in gem
  module Errors
    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
    #
    # Define errors to gems
    class RRJError < StandardError
      # Initialize a error standard in this gem and writing in log file
      #
      # @param [String] message Text returning in raise
      # @param [Symbol] level Important to error
      def initialize(message, level)
        super(message)
        write_error(message, level)
      end

      private

      def log
        RubyRabbitmqJanus::Tools::Log
      end

      def logger
        log.instance
      end

      def write_error(message, level)
        log.instance_method(level).bind(logger).call(message)
      end
    end
  end
end

require 'rrj/errors/base/base'
require 'rrj/errors/janus/janus'
require 'rrj/errors/tools/tools'
require 'rrj/errors/rabbit/rabbit'
