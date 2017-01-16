# frozen_string_literal: true

module RubyRabbitmqJanus
  module Rabbit
    module Publisher
      # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
      # Publish message in queue non exclusive. By default "to-janus".
      # This an option in config to this gem.
      class PublishNonExclusive < Publisher
        # Define an publisher for create non exclusive queue
        def initialize(exchange)
          @reply = exchange.queue(queue_from)
          super(exchange)
        end

        # Send an message to queue
        def publish(request)
          super(request)
        end

        private

        attr_reader :reply

        # Define queue used for posting a message to API public
        def queue_from
          Tools::Config.instance.queue_from
        end
      end
    end
  end
end
