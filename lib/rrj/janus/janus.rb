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
      @msg = DefineMessage.new
    end

    # Send a message with type
    def send_message(type)
      @logs.info "Send message type : #{type}"
      # Create message
      so = @msg.type_message(type)
      # Send message
      so.send(@channel)

      if type == :create
        destroy = MessageDestroy.new(so.transaction, so.correlation_id)
        destroy.msg
      end
    end
  end
end
