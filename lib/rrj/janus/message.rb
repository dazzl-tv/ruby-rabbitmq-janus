# frozen_string_literal: true

require 'json'
require 'securerandom'

module RRJ
  # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
  # Message Janus sending to rabbitmq server
  # @!attribute [r] correlation_id
  #   Represent an unique identifier to communication between in RabbitMQ queue janus
  # @!attribute [r] type
  #   Is a type of message (:info, :create)
  # @!attribute [r] plugin
  #   Name of plugin used by janus
  # @!attribute [r] transaction
  #   Transaction identifier used by janus
  class MessageJanus
    attr_reader :type, :information

    def initialize(type)
      @transaction = [*('A'..'Z'), *('0'..'9')].sample(10).join
      @correlation_id = SecureRandom.uuid
      @type = type
    end

    # Send a message to RabbitMQ server
    def send(channel, queue_to)
      @message = channel.default_exchange
      @reply_queue = channel.queue('', exclusive: true)
      @message.publish(msg,
                       routing_key: queue_to,
                       correlation_id: @correlation_id,
                       content_type: 'application/json')
    end

    private

    # Define plugin used
    def set_plugin
      # @plugin = 'janus.plugin.dazzl.videocontrol'
      @plugin = 'janus.plugin.echotest'
    end
  end
end
