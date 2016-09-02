# frozen_string_literal: true

require 'json'

module RRJ
  # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
  # Communication to RabbitMQ with format for Janus message
  class Janus
    # Returns a new instance of Janus
    # @param connection [String] Connection to RabbitMQ server
    # @param logs [RRJ::Log] Instance to log
    def initialize(connection, options, logs)
      @channel = connection.create_channel
      @queues = options['queues']
      @plugins = options['janus']['plugins']
      @logs = logs
    end

    # Send a message to RabbitMQ
    def send(request, opts)
      message = MessageJanus.new(@plugins, @logs, opts)
      message.send(request, @channel, @queues['queue_to'])
    end

    # Read a message to RabbitMQ
    def read(info_message, connection)
      response = ResponseJanus.new(@channel, connection, @logs, info_message)
      response.read(@queues['queue_from'])
    end
  end
end
