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

    # Returns a new instance of Janus
    # @param connection [String] Connection to RabbitMQ server
    # @param logs [RRJ::Log] Instance to log
    def initialize(connection, logs)
      @connection = connection
      @logs = logs
    end

    # Send a message
    # @deprecated
    def send_message
      @channel = @connection.create_channel
      message_info = MessageJanus.new
      msg = message_info.msg(:server_info)

      @logs.write 'To janus'
      x = @channel.topic('from-janus')
      x.publish(msg)

      @logs.write 'From janus'
      x = @channel.topic('to-janus')
      x.publish(msg)

      @logs.write(msg.to_s)
    end
  end
end
