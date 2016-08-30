# frozen_string_literal: true

require 'json'

module RRJ
  # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
  # Communication to RabbitMQ with format for Janus message
  class Janus
    # Returns a new instance of Janus
    # @param connection [String] Connection to RabbitMQ server
    # @param logs [RRJ::Log] Instance to log
    def initialize(connection, queues, logs)
      @channel = connection.create_channel
      @queues = queues
      @logs = logs
    end

    def send(request)
      message = MessageJanus.new
      message.send(request, @channel, @queues['queue_to'])
    end

    # Send a message with type
    def send_message(message)
      @message = message
      @logs.info "Create message : #{@message.type}"

      # Send message
      @message.send(@channel, @queues['queue_to'])
    end

    # Read a response
    def read_message(message)
      @message = message
      @message.read(@channel, @queues['queue_from'])
    end
  end
end
