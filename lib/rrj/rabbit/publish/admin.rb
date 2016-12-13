# frozen_string_literal: true

module RubyRabbitmqJanus
  module Rabbit
    module Publisher
      # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
      # This publisher send and read an message in admin queues
      class PublisherAdmin < Publisher
        # Intialize an queue non eclusive for admin/monitor API with Janus
        def initialize(exchange)
          @reply = exchange.queue(queue_from)
          super(exchange)
          subscribe_to_queue
        end

        # Send an message to queue and waiting a response
        def send_a_message(request)
          super(request)
          return_response
        end

        private

        attr_reader :reply

        # Define queue used for posting a message to API admin
        def queue_from
          Tools::Config.instance.queue_admin_from
        end
      end
    end
  end
end
