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
  # @!attribute [r] transaction
  #   @return [String] represente a random string (letter uppercase and number) with
  #   length to 8
  class Janus
    attr_reader :queue, :channel, :logs, :transaction

    # Returns a new instance of Janus
    # @param connection [String] Connection to RabbitMQ server
    # @param logs [RRJ::Log] Instance to log
    def initialize(connection, logs)
      @connection = connection
      @logs = logs
      @transaction = [*('A'..'Z'), *('0'..'9')].sample(8).join
    end

    # Send a message
    # @deprecated
    def send_message
      @channel = @connection.create_channel
      message_info = MessageJanus.message(:server_info)

      @logs.write 'To janus'
      x = @channel.topic('from-janus')
      x.publish(message_info)

      @logs.write 'From janus'
      x = @channel.topic('to-janus')
      x.publish(message_info)

      @logs.write(message_info)
    end
  end
end
