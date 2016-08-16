# frozen_string_literal: true

require 'bunny'

module RRJ
  # Initialize gem
  class RRJ
    attr_reader :rabbit, :logs, :settings

    def initialize
      @logs = Log.new

      load_configuration_gem
      load_connection_rabbitmq
    end

    private

    def load_configuration_gem
      @settings = Config.new(@logs)
    end

    def load_connection_rabbitmq
      @rabbit = RabbitMQ.new(@settings, @logs)
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
