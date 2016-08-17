# frozen_string_literal: true

module RRJ
  # Communication to RabbitMQ with format for Janus message
  class Janus
    attr_reader :queue, :logs

    def initialize(queue, logs)
      @logs = logs
      @queue = queue
    end

    def create_message
      @logs.write 'Create message'
    end

    def listen_queue
      @logs.write "Listen QUEUE [#{@queue.name}]"
      @queue.subscribe(manual_ack: true, block: true) do |_info, properties, body|
        puts "[x] Received #{properties}::#{body}"
      end
    end
  end
end
