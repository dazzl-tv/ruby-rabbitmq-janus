# frozen_string_literal: true

module RubyRabbitmqJanus
  module Rabbit
    module Publisher
      # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
      #
      # Publish message in queue non exclusive. By default "to-janus".
      # This an option in config to this gem.
      class NonExclusive < Base
        # Define an publisher for create non exclusive queue
        def initialize(exchange)
          @reply = exchange.queue(Tools::Config.instance.queue_from)
          super(exchange)
        end

        # Send an message to queue
        #
        # @param [String] request JSON request sending to rabbitmq queue
        #
        # rubocop:disable Lint/UselessMethodDefinition
        def publish(request)
          super(request)
        end
        # rubocop:enable Lint/UselessMethodDefinition
      end
    end
  end
end
