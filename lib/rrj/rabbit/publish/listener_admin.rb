# frozen_string_literal: true

module RubyRabbitmqJanus
  module Rabbit
    module Publisher
      # Listener to admin queue
      class ListenerAdmin < Listener
        private

        def subscribe_queue
          reply = @rabbit.queue(Tools::Config.instance.queue_admin_from)
          @rabbit.prefetch(1)
          reply.bind(binding).subscribe(opts_subs) do |info, prop, payload|
            Tools::Log.instance.info \
              "[X] Message ADMIN reading ##{prop['correlation_id']}"
            synchronize_response(info, payload)
          end
        end
      end
    end
  end
end
