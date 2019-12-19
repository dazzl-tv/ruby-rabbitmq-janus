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
        write_error(message, level)
        super(message)
      end

      private

      def write_error(message, level = :unknown)
        if defined?(::Log)
          ::Log.send(level.class.eql?(Symbol) ? level : int_to_level(level),
                     message)
        else
          p "#{level}, #{message}"
        end
      end

      def int_to_level(sym_level)
        %I[debug info warn error fatal unknown].index(sym_level)
      end
    end
  end
end

require 'rrj/errors/base/base'
require 'rrj/errors/janus/janus'
require 'rrj/errors/process/event'
require 'rrj/errors/process/event_admin'
require 'rrj/errors/tools/tools'
require 'rrj/errors/rabbit/rabbit'
