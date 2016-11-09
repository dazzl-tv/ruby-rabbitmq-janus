# frozen_string_literal: true

module RubyRabbitmqJanus
  module Rabbit
    module Publisher
      # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
      class PublishExclusive < BasePublisher
        # Initialize an queue exclusive and generated automaticaly by bunny
        def initialize(exchange, name_queue)
          @reply = exchange.queue(name_queue, exclusive: true)
          super(exchange)
        end

        # Name to queue used for this publisher
        # @return [String] Name to queue used
        def queue_name
          @reply.name
        end
      end
    end
  end
end
