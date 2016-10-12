# frozen_string_literal: true

module RubyRabbitmqJanus
  module Rabbit
    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
    # Manage properties to message sending in rabbitmq queue
    class Propertie
      # Initialize a message sending to rabbitmq
      def initialize
        @correlation = SecureRandom.uuid
      end

      # Define options sending to rabbitmq
      def options
        {
          routing_key: Config.instance.options['queues']['queue_to'],
          correlation_id: @correlation,
          content_type: 'application/json'
        }
      end
    end
  end
end
