# frozen_string_literal: true

module RubyRabbitmqJanus
  module Rabbit
    module Publisher
      # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
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

        # return an response when signal is trigger
        def return_response
          @lock.synchronize do
            @condition.wait(@lock)
            response
          end
        end
      end
    end
  end
end

require 'publisher'
require 'listener'
