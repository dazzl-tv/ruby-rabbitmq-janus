# frozen_string_literal: true

# :reek:InstanceVariableAssumption

module RubyRabbitmqJanus
  module Rabbit
    module Listener
      # Listener to admin queue
      class JanusInstance < ListenerFrom
        private

        def subscribe_queue
          reply = @rabbit.queue(Tools::Config.instance.queue_janus_instance)
          @rabbit.prefetch(1)
          reply.bind(binding).subscribe(opts_subs) do |info, prop, payload|
            info_subscribe(info, prop, payload)
            synchronize_response(info, payload)
          end
        end
      end
    end
  end
end
