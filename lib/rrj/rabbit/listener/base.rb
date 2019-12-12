# frozen_string_literal: true

# :reek:NilCheck

module RubyRabbitmqJanus
  module Rabbit
    module Listener
      # Base for listeners
      class Base < RubyRabbitmqJanus::Rabbit::BaseEvent
        # Define an publisher
        #
        # @param [String] rabbit Information connection to RabbitMQ server
        def initialize(rabbit)
          super()
          @rabbit = rabbit.channel
          subscribe_queue
        rescue
          raise Errors::Rabbit::Listener::Base::Initialize
        end

        # Listen a queue and return a body response
        def listen_events
          semaphore.wait
          response = nil
          lock.synchronize do
            response = responses.shift
            check(response)
          end
          yield response.event, response
        rescue
          raise Errors::Rabbit::Listener::Base::ListenEvents, reply
        end

        private

        attr_accessor :rabbit, :responses

        def binding
          @rabbit.direct('amq.direct')
        end

        def opts_subs
          { block: false, manual_ack: true, arguments: { 'x-priority': 2 } }
        end

        def info_subscribe(info, _prop, payload)
          ::Log.debug info
          ::Log.debug '[X] Message reading'
          ::Log.info payload
        end

        def check(response)
          raise Errors::Rabbit::Listener::ResponseNil, response \
            if response.nil?
          raise Errors::Rabbit::Listener::ResponseEmpty, response \
            if response.to_hash.size.zero?
        end
      end
    end
  end
end

require 'rrj/rabbit/listener/from'
require 'rrj/rabbit/listener/from_admin'
