# frozen_string_literal: true

require 'rrj/janus/responses/janus_instance'

module RubyRabbitmqJanus
  module Rabbit
    module Listener
      # :reek:InstanceVariableAssumption

      # Listener to admin queue
      class JanusInstance < From
        private

        def subscribe_queue
          reply = @rabbit.queue(Tools::Config.instance.queue_janus_instance)
          @rabbit.prefetch(1)
          reply.bind(binding).subscribe(opts_subs) do |info, prop, payload|
            info_subscribe(info, prop, payload)
            synchronize_response(info, payload)
          end
        rescue => exception
          raise RubyRabbitmqJanus::Errors::Rabbit::Listener::
                JanusInstance::ListenEvents, exception
        end

        # Sending an signal when an response is reading in queue
        def synchronize_response(info, payload)
          lock.synchronize do
            response = Janus::Responses::JanusInstance.new(JSON.parse(payload))
            @responses.push(response)
          end
          @rabbit.acknowledge(info.delivery_tag, false)
          semaphore.signal
        end
      end
    end
  end
end
