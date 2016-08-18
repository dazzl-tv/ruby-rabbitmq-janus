# frozen_string_literal: true

require 'json'
require 'securerandom'

module RRJ
  # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
  # Communication to RabbitMQ with format for Janus message
  # @!attribute [r] queue
  #   @return [Bunny::Queue] Represent a queue for one connection with RabbitMQ
  # @!attribute [r] channel
  #   @return [Bunny::Channel] Represent a channel for one connection with RabbitMQ
  # @!attribute [r] logs
  #   @return [RRJ::Log] Log to gem
  # @!attribute [r] id
  #   @return [String]
  class Janus
    attr_reader :queue, :channel, :logs, :id

    # Returns a new instance of Janus
    # @param connection [String] Connection to RabbitMQ server
    # @param logs [RRJ::Log] Instance to log
    def initialize(connection, logs)
      @connection = connection
      @logs = logs
    end

    # Send a message
    def send_message
      @channel = @connection.create_channel
      @id = SecureRandom.uuid

      @x = @channel.default_exchange
      @server_queue = 'to-janus'
      @reply_queue = @channel.queue('', exclusive: true)

      @x.publish(message_info_to_string,
                 routing_key: 'to-janus',
                 correlation_id: @id,
                 content_type: 'application/json',
                 reply_to: @reply_queue.name)
    end

    # Listen message to queue
    def listen_messages
      @channel = @connection.create_channel
      @queue = @channel.queue('from-janus')
      @queue.subscribe(block: true) do |delivery_info, properties, body|
        @logs.write "[x] devlivery_info : #{delivery_info}"
        @logs.write "[x] body : #{body}"
        @logs.write "[x] properties: #{properties}"
      end
    end

    private

    def message_info_to_string
      message_info = MessageJanus.new
      message_info.msg(:info).to_s
    end
  end
end
