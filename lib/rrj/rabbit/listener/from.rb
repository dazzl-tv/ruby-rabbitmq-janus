# frozen_string_literal: true

module RubyRabbitmqJanus
  module Rabbit
    module Listener
      # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
      #
      # This publisher don't post message. Is listen just an standard queue to
      # Janus. By default is "from-janus". It's a parameter in config to this
      # gem.
      class From < Base
        private

        def reply
          rabbit.queue(Tools::Config.instance.queue_from)
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
            response = Janus::Responses::Event.new(JSON.parse(payload))
            responses.push(response)
          end
          rabbit.acknowledge(info.delivery_tag, false)
          semaphore.signal
        end
      end
    end
  end
end
