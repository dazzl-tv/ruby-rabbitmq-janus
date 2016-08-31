# frozen_string_literal: true

require 'json'

module RRJ
  # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
  # Communication to RabbitMQ with format for Janus message
  class Janus
    # Returns a new instance of Janus
    # @param connection [String] Connection to RabbitMQ server
    # @param logs [RRJ::Log] Instance to log
    def initialize(connection, queues, logs)
      @channel = connection.create_channel
      @queues = queues
      @logs = logs
    end

    def send(request)
      message = MessageJanus.new
      @logs.info "Request template sending : #{request}"
      message.send(request, @channel, @queues['queue_to'])
    end

    def read(info_message)
      response = ResponseJanus.new(info_message)
      @logs.info "Information request search : #{info_message}"
      response.read(@channel, @queues['queue_from'])
    end
  end
end
