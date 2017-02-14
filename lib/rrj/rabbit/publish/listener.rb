# frozen_string_literal: true

module RubyRabbitmqJanus
  module Rabbit
    module Publisher
      # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
      # This publisher don't post message. Is listen just an standard queue to
      # Janus. By default is "from-janus". It's a parameter in config to this
      # gem.
      class Listener < BasePublisher
        # Define an publisher
        #
        # @param [String] rabbit Information connection to rabbitmq server
        def initialize(rabbit)
          super()
          @responses = []
          @rabbit = rabbit.channel
          subscribe_queue
        end

        # Listen a queue and return a body response
        def listen_events
          Tools::Log.instance.debug 'Waiting event...'
          @semaphore.wait
          Tools::Log.instance.info 'Janus event received .. treatment ..'
          response = nil
          lock.synchronize do
            response = @responses.shift
          end
          yield response.event, response
        end

        private

        def queue_name
          Tools::Config.instance.queue_from
        end

        # Subscribe queue
        def subscribe_queue
          reply = @rabbit.queue(queue_name)
          @rabbit.prefetch(1)
          reply.bind(binding).subscribe(opts_subs) do |info, prop, payload|
            log_message_id(prop)
            synchronize_response(info, payload)
          end
        end

        # Define type binding used for subscriber
        def binding
          @rabbit.direct('amq.direct')
        end

        # Options subscribe
        def opts_subs
          { block: false, manual_ack: true, arguments: { 'x-priority': 2 } }
        end

        # Counts transmitted messages
        def log_message_id(propertie)
          message_id = propertie.message_id
          Tools::Log.instance.info "[X] Message reading with ID #{message_id}"
        end

        # Sending an signal when an response is reading in queue
        def synchronize_response(info, payload)
          lock.synchronize do
            @responses.push(Janus::Responses::Event.new(JSON.parse(payload)))
          end
          @rabbit.acknowledge(info.delivery_tag, false)
          @semaphore.signal
        end
      end
    end
  end
end
