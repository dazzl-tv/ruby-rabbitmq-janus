# frozen_string_literal: true

require 'bunny'

module RRJ
  # Class for connection with RabbitMQ Server
  class RabbitMQ
    attr_reader :connection, :logs, :settings, :queue, :channel, :janus

    def initialize(configuration, logs)
      @settings = configuration
      @logs = logs

      start_communication
    end

    def listen
      @connection.start
      begin
        @janus.listen_queue
      rescue Interrupt => _
        @connection.close
      end
    end

    private

    def start_communication
      @connection = Bunny.new(read_options_server)
      @connection.start
      @channel = @connection.create_channel
      @queue = @channel.queue('to-janus')

      @janus = Janus.new(@queue, @channel, @logs)
      @janus.create_message
      @janus.info_message

      @connection.close
    end

    def read_options_server
      hash = {}
      @logs.write 'Prepare connection with RabbitMQ server : '
      @settings.options.fetch('server').each do |key, server|
        @logs.write '[' + key.to_s + '] ' + server.to_s
        hash.merge!(key.to_sym => server.to_s)
      end
      hash
    end
  end
end
