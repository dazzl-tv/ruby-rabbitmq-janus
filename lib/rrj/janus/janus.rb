# frozen_string_literal: true

require 'json'

module RRJ
  # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
  # Communication to RabbitMQ with format for Janus message
  # @!attribute [r] queue
  #   @return [Bunny::Queue] Represent a queue for one connection with RabbitMQ
  # @!attribute [r] channel
  #   @return [Bunny::Channel] Represent a channel for one connection with RabbitMQ
  # @!attribute [r] logs
  #   @return [RRJ::Log] Log to gem
  class Janus
    attr_reader :queue, :channel, :logs

    # Type message sending
    CONTENT_TYPE = 'application/json'

    # Queue to message sending
    ROUTING = 'to-janus'

    # Returns a new instance of Janus
    # @param connection [String] Connection to RabbitMQ server
    # @param logs [RRJ::Log] Instance to log
    def initialize(connection, logs)
      @connection = connection
      @logs = logs
    end

    # Send a message
    def send_message
      send_message_info
      send_message_create
    end

    # Listen message to queue
    def listen_messages
      @channel = @connection.create_channel
      @queue = @channel.queue('from-janus')
      @queue.subscribe(block: true) do |delivery_info, properties, body|
        @logs.write "[x] devlivery_info : #{delivery_info}", :debug
        @logs.write "[x] body : #{body}", :debug
        @logs.write "[x] properties: #{properties}", :debug
      end
    end

    private

    def send_message_info
      @channel = @connection.create_channel
      @x = @channel.default_exchange
      @reply_queue = @channel.queue('', exclusive: true)
      msg = Info.new(@logs)
      @x.publish(msg.msg,
                 routing_key: ROUTING,
                 correlation_id: msg.correlation_id,
                 content_type: CONTENT_TYPE,
                 reply_to: @reply_queue.name)
    end

    def send_message_create
      @channel = @connection.create_channel
      @x = @channel.default_exchange
      @reply_queue = @channel.queue('', exclusive: true)
      msg = Create.new(@logs)
      @x.publish(msg.msg,
                 routing_key: ROUTING,
                 correlation_id: msg.correlation_id,
                 content_type: CONTENT_TYPE,
                 reply_to: @reply_queue.name)
    end
  end
end
