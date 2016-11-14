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
        end

        private

        attr_reader :reply

        # Define queue used for posting a message to API admin
        def queue_from
          Tools::Config.instance.options['queues']['admin']['queue_from']
        end
      end
    end
  end
end
