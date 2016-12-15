# frozen_string_literal: true

module RubyRabbitmqJanus
  # Define all error in gem
  module Errors
    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>

    # Define errors to gems
    class RRJError < StandardError
      # Initialize a error standard in this gem
      # @param [String] message Text returning in raise
      # @param [Symbol] level Important to error
      def initialize(message, level)
        super(message)
        log = Tools::Log.instance
        Tools::Log.instance_method(level).bind(log).call(message)
      end
    end

    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>

    # Define an exception if gem dont initialize correctly
    class RRJErrorInit < RRJError
      # Initialize a error for instanciate class. It's a fatal error
      # @param [String] message Text returning in raise
      def initialize(message)
        super "Gem is not instanciate correctly : #{message}", :fatal
      end
    end

    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>

    # Define an error if method message_post given an exception
    class RRJErrorPost < RRJError
      # Initialize a error for message posting. It's a fatal error
      # @param [String] message Text returning in raise
      def initialize(message)
        super "Post message is failed : #{message}", :fatal
      end
    end

    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>

    # Define an error if method transaction given an exception
    class RRJErrorTransaction < RRJError
      # Initialize a error for transaction failed. It's a fatal error
      # @param [String] message Text returning in raise
      def initialize(message)
        super "Transaction is failed : #{message}", :fatal
      end
    end

    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
    # Define an error if method start_handle given an exception
    class RRJErrorHandle < RRJError
      # Initialize a error for transaction with a handle. It's a fatal error
      # @param [String] message Text returning in raise
      def initialize(message)
        super "Transaction handle is failed : #{message}", :fatal
      end
    end
  end
end

require 'rrj/errors/janus'
require 'rrj/errors/janus_message'
require 'rrj/errors/janus_response'
require 'rrj/errors/janus_transaction'

require 'rrj/errors/config'
require 'rrj/errors/rabbit'
