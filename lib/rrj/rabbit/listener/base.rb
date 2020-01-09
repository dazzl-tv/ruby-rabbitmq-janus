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
        end

        private

        attr_accessor :rabbit, :responses

        def binding
          @rabbit.direct('amq.direct')
        end

        def opts_subs
          { block: false, manual_ack: false, arguments: { 'x-priority': 2 } }
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

        def subscribe_queue
          rabbit.prefetch(1)
          reply.bind(binding).subscribe(opts_subs) do |info, prop, payload|
            info_subscribe(info, prop, payload)
            synchronize_response(info, payload)
          end
        end

        def synchronize_response(info, payload)
          lock.synchronize do
            response = response_class(payload)
            # rabbit.acknowledge(info.delivery_tag, false)
            responses.push(response)
          end
          semaphore.signal
        end
      end
    end
  end
end

require 'rrj/rabbit/listener/from'
require 'rrj/rabbit/listener/from_admin'
