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

    # Send a info message
    # @deprecated Just for test
    def send_info_message
      info_message = MessageInfo.new
      info_message.send(@channel)
      info_response = ResponseInfo.new
      @logs.warn info_response.receive(@channel)
    end

    # Send a message
    # @deprecated Just for test
    def send_create_message
      create_message = MessageCreate.new
      create_message.send(@channel)
      create_response = ResponseJanus.new
      @logs.warn create_response.receive(@channel)
    end

    # Listen message to queue
    # @deprecated
    def listen_messages
      @channel = @connection.create_channel
      @queue = @channel.queue('from-janus')
      @queue.subscribe(block: true) do |delivery_info, properties, body|
        message = \
          "[x] devlivery_info : #{delivery_info}\n" \
          "[x] body : #{body}\n" \
          "[x] properties: #{properties}"
        @logs.debug message
      end
    end
  end
end
