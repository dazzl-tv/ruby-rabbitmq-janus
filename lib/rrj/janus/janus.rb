# frozen_string_literal: true

require 'json'

module RRJ
  # Communication to RabbitMQ with format for Janus message
  class Janus
    attr_reader :queue, :channel, :logs, :transaction

    def initialize(queue, channel, logs)
      @queue = queue
      @channel = channel
      @logs = logs
    end

    def create_message
      @logs.write 'Create message'
      x = @channel.topic('from-janus')
      msg = message_create
      @logs.write msg
      x.publish(msg)
    end

    def info_message
      @logs.write 'Info message'
      msg = message_info
      @logs.write msg
      x = @channel.topic('from-janus')
      x.publish(msg)
    end

    def listen_queue
      @logs.write "Listen QUEUE [#{@queue.name}]"
      @queue.subscribe(manual_ack: true, block: true) do |_info, properties, body|
        @logs.write "[x] Received #{properties}::#{body}"
      end
    end

    private

    def message_create
      @transaction = [*('A'..'Z'), *('0'..'9')].sample(8).join
      { janus: 'create', transaction:  @transaction }.to_json
    end

    def message_info
      { janus: 'info', transaction:  @transaction }.to_json
    end
  end
end
