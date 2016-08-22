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
  class MessageJanus
    attr_reader :correlation_id, :type, :plugin, :transaction

    # Prepare transaction, correlation_id and plugin
    def initialize
      @transaction = [*('A'..'Z'), *('0'..'9')].sample(10).join
      @correlation_id = SecureRandom.uuid
    end

    # Send a message to RabbitMQ server
    def send(channel)
      @message = channel.default_exchange
      @reply_queue = channel.queue('', exclusive: true)
      @logs.debug msg
      @message.publish(msg,
                       routing_key: 'to-janus',
                       correlation_id: @correlation_id,
                       content_type: 'application/json',
                       reply_to: @reply_queue.name)
    end

    private

    def set_plugin
      @plugin = 'janus.plugin.dazzl.videocontrol'
    end
  end
end
