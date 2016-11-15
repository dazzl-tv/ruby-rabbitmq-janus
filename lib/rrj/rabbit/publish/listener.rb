# frozen_string_literal: true

module RubyRabbitmqJanus
  module Rabbit
    module Publisher
      # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
      # This publisher don't post message. Is listen just an standard queue to Janus.
      # By default is "from-janus". It's a parameter in config to this gem.
      class Listener < BasePublisher
        # Define an publisher
        def initialize(rabbit)
          super()
          @response = nil
          @count = 1
          @rabbit = rabbit.channel
          @reply = @rabbit.queue(Tools::Config.instance.options['queues']['queue_from'])
          Tools::Log.instance.debug "Waiting message from queue : #{@reply.name}"
          @reply.subscribe do |_info_delivery, _propertie, payload|
            synchronize_response(payload)
          end
        end

        # Listen a queue and return a body response
        def listen_events
          lock.synchronize do
            condition.wait(lock)
            yield @response.event, @response.data, @response.jsep
          end
        end

        private

        # Sending an signal when an response is reading in queue
        def synchronize_response(payload)
          @response = Janus::Response.new(JSON.parse(payload))
          Tools::Log.instance.info \
            "[X] Message number reading ##{@count} --\n\r" \
            "#{@response.to_hash}"
          @count += 1
          lock.synchronize { condition.signal }
        end
      end
    end
  end
end
