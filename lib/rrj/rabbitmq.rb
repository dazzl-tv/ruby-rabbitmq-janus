# frozen_string_literal: true

require 'bunny'

module RRJ
  # Class for connection with RabbitMQ Server
  class Rabbit
    attr_reader :connection, :logs, :settings

    def initialize(configuration, logs)
      @settings = configuration
      @logs = logs

      @logs.write 'Prepare connection with RabbitMQ server'
      @logs.write @settings.inspect
    end
  end
end
