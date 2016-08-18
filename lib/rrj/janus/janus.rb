# frozen_string_literal: true

require 'json'

module RRJ
  # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
  # Communication to RabbitMQ with format for Janus message
  class Janus
    # Returns a new instance of Janus
    # @param connection [String] Connection to RabbitMQ server
    # @param logs [RRJ::Log] Instance to log
    def initialize(connection, logs)
      @connection = connection
      @channel = @connection.create_channel
      @logs = logs
    end

    # Send a message
    def send_message
      i = Info.new(@channel, @logs)
      i.send

      c = Create.new(@channel, @log)
      c.send
    end

    # Listen message to queue
    # @deprecated
    def listen_messages
      @channel = @connection.create_channel
      @queue = @channel.queue('from-janus')
      @queue.subscribe(block: true) do |delivery_info, properties, body|
        @logs.write "[x] devlivery_info : #{delivery_info}", :debug
        @logs.write "[x] body : #{body}", :debug
        @logs.write "[x] properties: #{properties}", :debug
      end
    end
  end
end
