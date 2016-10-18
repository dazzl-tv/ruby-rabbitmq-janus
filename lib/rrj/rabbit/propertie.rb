# frozen_string_literal: true

module RubyRabbitmqJanus
  module Rabbit
    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
    # Manage properties to message sending in rabbitmq queue
    class Propertie
      # Initialize a message sending to rabbitmq
      def initialize
        Tools::Log.instance.debug 'initalize a propertie to message'
        @correlation = SecureRandom.uuid
      end

      # Define options sending to rabbitmq
      def options
        Tools::Log.instance.debug 'Add options to propertie to message'
        {
          routing_key: Tools::Config.instance.options['queues']['queue_to'],
          correlation_id: @correlation,
          content_type: 'application/json'
        }
      end
    end
  end
end
