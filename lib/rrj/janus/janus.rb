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
    # @param queue [String] Name of queue used
    # @param channel [String] Name of channel used
    # @param logs [RRJ::Log] Instance to log
    def initialize(queue, channel, logs)
      @queue = queue
      @channel = channel
      @logs = logs
    end

    # @deprecated
    def create_message
      @logs.write 'Create message'
      x = @channel.topic('from-janus')
      msg = message_create
      @logs.write msg
      x.publish(msg)
    end

    # @deprecated
    def info_message
      @logs.write 'Info message'
      msg = message_info
      @logs.write msg
      x = @channel.topic('from-janus')
      x.publish(msg)
    end

    # @deprecated
    def listen_queue
      @logs.write "Listen QUEUE [#{@queue.name}]"
      @queue.subscribe(manual_ack: true, block: true) do |_info, properties, body|
        @logs.write "[x] Received #{properties}::#{body}"
      end
    end

    private

    # @deprecated
    def message_create
      @transaction = [*('A'..'Z'), *('0'..'9')].sample(8).join
      { janus: 'create', transaction:  @transaction }.to_json
    end

    # @deprecated
    def message_info
      { janus: 'info', transaction:  @transaction }.to_json
    end
  end
end
