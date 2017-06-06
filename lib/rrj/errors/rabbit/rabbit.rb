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

require 'rrj/errors/rabbit/connect'
require 'rrj/errors/rabbit/propertie'

require 'rrj/errors/rabbit/publish/base_publisher'
require 'rrj/errors/rabbit/publish/admin'
require 'rrj/errors/rabbit/publish/exclusive'
require 'rrj/errors/rabbit/publish/listener'
require 'rrj/errors/rabbit/publish/non_exclusive'
require 'rrj/errors/rabbit/publish/publisher'
