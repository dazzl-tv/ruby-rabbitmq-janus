# frozen_string_literal: true

module RubyRabbitmqJanus
  module Errors
    # Define a super class for all error in module Rabbit
    class BaseRabbit < RRJError
      def initialize(message, level = :fatal)
        super "[Rabbit]#{message}", level
      end
    end
  end
end

require 'rrj/errors/rabbit/base_event'
require 'rrj/errors/rabbit/connect'
require 'rrj/errors/rabbit/propertie'

require 'rrj/errors/rabbit/listener/base'
require 'rrj/errors/rabbit/listener/from'
require 'rrj/errors/rabbit/listener/from_admin'

require 'rrj/errors/rabbit/publisher/base'
require 'rrj/errors/rabbit/publisher/admin'
require 'rrj/errors/rabbit/publisher/exclusive'
require 'rrj/errors/rabbit/publisher/keepalive'
require 'rrj/errors/rabbit/publisher/non_exclusive'
