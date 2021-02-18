# frozen_string_literal: true

require 'semaphore'

module RubyRabbitmqJanus
  module Rabbit
    # Define an module for create an publisher
    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>

    # # Parent class for all publisher
    # This element send and read a message in rabbitmq Queue
    #
    # @!attribute [r] responses
    #   @return [RubyRabbitmqJanus::Janus::Responses::Response]
    #     Given an array of Janus response
    #
    # @abstract Publish message in RabbitMQ
    class BaseEvent
      attr_reader :responses

      # Define a base publisher
      def initialize
        @responses = []
        @semaphore = Semaphore.new
        @lock = Mutex.new
      end

      private

      attr_accessor :semaphore, :lock

      def return_response
        @semaphore.wait
        response = nil
        @lock.synchronize do
          response = @responses.shift
        end
        response
      end
    end
  end
end

require 'rrj/rabbit/publisher/base'
require 'rrj/rabbit/listener/base'
