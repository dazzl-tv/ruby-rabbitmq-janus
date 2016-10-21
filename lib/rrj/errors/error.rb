# frozen_string_literal: true

module RubyRabbitmqJanus
  # Define all error in gem
  module Errors
    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
    # Define errors to gems
    class RRJError < StandardError
      def initialize(message, level)
        super(message)
        Tools::Log.instance_method(level).bind(Tools::Log.instance).call(message)
      end
    end

    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
    # Define an exception if gem dont initialize correctly
    class RRJErrorInit < RRJError
      def initialize(message)
        super "Gem is not instanciate correctly : #{message}", :fatal
      end
    end

    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
    # Define an error if method message_post given an exception
    class RRJErrorPost < RRJError
      def initialize(message)
        super "Post message is failed : #{message}", :fatal
      end
    end

    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
    # Define an error if method transation given an exception
    class RRJErrorTransaction < RRJError
      def initialize(message)
        super "Transaction is failed : #{message}", :fatal
      end
    end

    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
    # Define an error if method start_handle given an exception
    class RRJErrorHandle < RRJError
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
require 'rrj/errors/request'
