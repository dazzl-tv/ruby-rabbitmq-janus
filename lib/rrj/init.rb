# frozen_string_literal: true

require 'bunny'

module RRJ
  # Initialize gem
  class RRJ
    attr_reader :connection, :channel, :queue

    def initialize
      @connection = Bunny.new
      @connection.start

      @channel = @connection.create_channel
      @queue = @channel.queue('dazzl_queue_from_42')

      listen_messages
    end

    def listen_messages
      puts "[#{@queue.name}]"
      begin
        @queue.subscribe(manual_ack: true, block: true) do |_info, properties, body|
          puts "[x] Received #{properties}::#{body}"
        end
      rescue Interrupt => _
        @connection.close
      end
    end
  end
end
