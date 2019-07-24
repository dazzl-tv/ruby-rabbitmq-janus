# frozen_string_literal: true

# :reek:InstanceVariableAssumption

module RubyRabbitmqJanus
  module Rabbit
    module Listener
      # Listener to admin queue
      class FromAdmin < ListenerFrom
        private

        def subscribe_queue
          reply = @rabbit.queue(Tools::Config.instance.queue_admin_from)
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
