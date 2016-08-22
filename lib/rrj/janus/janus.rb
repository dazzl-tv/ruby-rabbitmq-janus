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
      @channel = connection.create_channel
      @logs = logs
    end

    # Send a message with type
    def send_message(message)
      @message = message
      @logs.info "Create message : #{@message.type}"

      # Send message
      @message.send(@channel)
    end

    def read_message(message)
      @message = message
      @logs.info 'Read message'
      @message.read(@channel)
    end
  end
end
