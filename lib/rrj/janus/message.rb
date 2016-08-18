# frozen_string_literal: true

require 'json'
require 'securerandom'

module RRJ
  # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
  # Model for Janus message sending or received to rabbitmq server
  class MessageJanus
    # Type message sending
    CONTENT_TYPE = 'application/json'

    # Queue to message sending
    ROUTING = 'to-janus'

    # @param channel [Bunny::Session] Channel to RabbitMQ send message
    # @param logs [RRJ::Log] Log instance
    def initialize(channel, logs)
      @transaction = [*('A'..'Z'), *('0'..'9')].sample(10).join
      @correlation_id = SecureRandom.uuid
      @channel = channel
      @logs = logs
    end

    # Send a message to RabbitMQ server
    def send
      @x = @channel.default_exchange
      @reply_queue = @channel.queue('', exclusive: true)
      @x.publish(msg,
                 routing_key: ROUTING,
                 correlation_id: @correlation_id,
                 content_type: CONTENT_TYPE,
                 reply_to: @reply_queue.name)
    end
  end
end
