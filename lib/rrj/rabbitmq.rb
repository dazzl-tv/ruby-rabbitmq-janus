# frozen_string_literal: true

require 'bunny'

module RRJ
  # Class for connection with RabbitMQ Server
  class Rabbit
    attr_reader :connection, :logs, :settings

    def initialize(configuration, logs)
      @settings = configuration
      @logs = logs

      start_communication
    end

    private

    def start_communication
      @logs.write 'Prepare connection with RabbitMQ server'
      @logs.write @settings.inspect

      @connection = Bunny.new
      @connection.start
      @channel = @connection.create_channel
      @queue = @channel.queue('from-janus')
      @connection.close
    end
  end
end
