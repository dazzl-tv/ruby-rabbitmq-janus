# frozen_string_literal: true

require 'json'
require 'securerandom'

module RRJ
  # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
  # Message Janus sending to rabbitmq server
  class MessageJanus
    attr_reader :correlation_id

    # Type message sending
    CONTENT_TYPE = 'application/json'

    # Queue to message sending
    ROUTING = 'to-janus'

    # Plugin unique name
    PLUGIN = 'janus.plugin.dazzl.videocontrol'

    # @param channel [Bunny::Session] Channel to RabbitMQ send message
    # @param logs [RRJ::Log] Log instance
    def initialize
      @transaction = [*('A'..'Z'), *('0'..'9')].sample(10).join
      @correlation_id = SecureRandom.uuid
    end

    # Send a message to RabbitMQ server
    def send(channel)
      @message = channel.default_exchange
      @reply_queue = channel.queue('', exclusive: true)
      @message.publish(msg,
                       routing_key: ROUTING,
                       correlation_id: @correlation_id,
                       content_type: CONTENT_TYPE,
                       reply_to: @reply_queue.name)
    end
  end
end
