# frozen_string_literal: true

module RubyRabbitmqJanus
  module Rabbit
    module Publisher
      # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
      class PublishExclusive < Publisher
        # Initialize an queue exclusive and generated automaticaly by bunny
        def initialize(exchange, name_queue)
          @reply = exchange.queue(name_queue, exclusive: true)
          super(exchange)
          subscribe_to_queue
        end

        # Send an message to queue and waiting a response
        def publish(request)
          super(request)
          return_response
        end

        private

        attr_reader :reply
      end
    end
  end
end
