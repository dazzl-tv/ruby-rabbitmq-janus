# frozen_string_literal: true

module RubyRabbitmqJanus
  # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
  # Manage properties to message sending in rabbitmq queue
  class Propertie
    def initialize
      @correlation = SecureRandom.uuid
    end

    def options
      {
        routing_key: Config.instance.options['queues']['queue_to'],
        correlation_id: @correlation,
        content_type: 'application/json'
      }
    end
  end
end
