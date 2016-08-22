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
      @abstract_message = DefineMessage.new(@logs)
    end

    # Send a message with type
    def send_message(type)
      @logs.info "Create message : #{type}"

      # Create message
      @message = @abstract_message.type_message(type, @logs)

      # Send message
      @message.send(@channel)

      # Writing in log information to message sending
      # sending_destroy(so.transaction, so.correlation_id)
    end

    def sending_destroy(transaction, correlation)
      @logs.debug "Transaction - #{transaction}"
      @logs.debug "Correlation - #{correlation}"

      # Destroy the session
      @logs.debug 'Send message type :destroy'
      destroy = MessageDestroy.new(transaction, correlation)
      destroy.msg
    end
  end
end
