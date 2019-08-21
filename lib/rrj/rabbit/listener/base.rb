# frozen_string_literal: true

# :reek:TooManyStatements

module RubyRabbitmqJanus
  module Rabbit
    module Listener
      # Base for listeners
      class Base < RubyRabbitmqJanus::Rabbit::BaseEvent
        # Define an publisher
        #
        # @param [String] rabbit Information connection to rabbitmq server
        def initialize(rabbit)
          super()
          @responses = []
          @rabbit = rabbit.channel
          subscribe_queue
        rescue
          raise Errors::Rabbit::Listener::Initialize
        end

        # Listen a queue and return a body response
        def listen_events
          semaphore.wait
          response = nil
          lock.synchronize do
            response = @responses.shift
          end
          yield response.event, response
        rescue => exception
          p exception
          raise Errors::Rabbit::Listener::ListenEvents
        end

        private

        attr_accessor :rabbit

        def binding
          @rabbit.direct('amq.direct')
        end

        def opts_subs
          { block: false, manual_ack: true, arguments: { 'x-priority': 2 } }
        end

        # Counts transmitted messages
        def log_message_id(propertie)
          message_id = propertie.message_id
          Tools::Log.instance.info "[X] Message reading with ID #{message_id}"
        end

        def info_subscribe(info, prop, payload)
          Tools::Log.instance.debug info
          Tools::Log.instance.info \
            "[X] Message reading ##{prop['correlation_id']}"
          Tools::Log.instance.debug payload
        end
      end
    end
  end
end

require 'rrj/rabbit/listener/from'
require 'rrj/rabbit/listener/from_admin'
require 'rrj/rabbit/listener/janus_instance'
