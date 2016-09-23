# frozen_string_literal: true

require 'json'

module RubyRabbitmqJanus
  # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
  # Communication to RabbitMQ with format for Janus message
  class Janus
    # Returns a new instance of Janus
    # @param connection [String] Connection to RabbitMQ server
    # @param logs [RRJ::Log] Instance to log
    def initialize(connection)
      @channel = connection.create_channel
    end

    # Send a message to RabbitMQ
    # @param request [String] Type request used by transaction
    # @param opts [Hash] Contains the parameters used by request if necessary
    # @return [Hash] Result to request
    def send(request, opts)
      message = Sync.new(opts, @channel)
      message.send(request)
    end

    def send_async(request, opts)
      message = ASync.new(opts, @channel)
      message.send(request)
    end

    # Read a message to RabbitMQ
    # @param info_message [Hash] Information request asking to janus
    # @param connection [Object] Object contains a information to connection
    # @return [Hash] Result to request
    def read(info_message, connection)
      response = ResponseJanus.new(@channel, connection, info_message)
      response.read
    end
  end
end
