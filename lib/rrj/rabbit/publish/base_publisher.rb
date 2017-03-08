# frozen_string_literal: true

module RubyRabbitmqJanus
  module Rabbit
    # Define an module for create an publisher
    module Publisher
      # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>

      # # Parent class for all publisher
      # This element send and read a message in rabbitmq Queue
      #
      # @!attribute [r] response
      #   @return [RubyRabbitmqJanus::Janus::Responses::Response]
      #     Given a Janus response
      #
      # @abstract Publish message in RabbitMQ
      class BasePublisher
        attr_reader :response

        # Define a base publisher
        def initialize
          Tools::Log.instance.debug 'Create an publisher'
          @response = nil
          @condition = ConditionVariable.new
          @lock = Mutex.new
        end

        private

        attr_accessor :condition, :lock

        def return_response
          @lock.synchronize do
            Tools::Log.instance.debug 'Response received'
            @condition.wait(@lock)
            @response
          end
        end
      end
    end
  end
end

require 'rrj/rabbit/publish/publisher'
require 'rrj/rabbit/publish/listener'
