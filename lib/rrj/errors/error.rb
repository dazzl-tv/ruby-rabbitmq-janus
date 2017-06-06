# frozen_string_literal: true

module RubyRabbitmqJanus
  # Define all error in gem
  module Errors
    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
    #
    # Define errors to gems
    class RRJError < StandardError
      # Initialize a error standard in this gem
      #
      # @param [String] message Text returning in raise
      # @param [Symbol] level Important to error
      def initialize(message, level)
        super(message)
        RubyRabbitmqJanus::Tools::Log.instance_method(level)\
          .bind(RubyRabbitmqJanus::Tools::Log.instance).call(message)
      end
    end
  end
end

require 'rrj/errors/base/base'
require 'rrj/errors/janus/janus'
require 'rrj/errors/tools/tools'
require 'rrj/errors/rabbit/rabbit'
