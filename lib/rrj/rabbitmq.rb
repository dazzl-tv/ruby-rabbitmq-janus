# frozen_string_literal: true

require 'bunny'

module RRJ
  # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
  # Class for connection with RabbitMQ Server
  class RabbitMQ
    # Return a new instance to RabbitMQ
    # @param configuration [RRJ::Config] Configuration file to gem
    # @param requests [Hash] Request sending to RabbitMQ
    # @param logs [RRJ::Log] Log to gem
    def initialize(configuration, requests, logs)
      @settings = configuration
      @logs = logs
      @requests = requests
      @connection = Bunny.new(read_options_server)
      @response = nil
    end

    def ask_request(request_type)
      execute_request do
        @response = @janus.send(@requests[request_type.to_s])
      end
    end

    def ask_response(info_request)
      execute_request do
        @response = @janus.read(info_request, @connection)
      end
    end

    private

    # Establish connection with RabbitMQ server
    # @return [RRJ::Janus] Janus object for manipulating data sending and receiving to
    #   rabbitmq server
    def open_server_rabbitmq
      @connection.start
    end

    # Close connection to rabbitmq server
    def close_server_rabbitmq
      @connection.close
    end

    # Use configuration information to connect RabbitMQ
    def read_options_server
      hash = {}
      @settings.options.fetch('server').each do |key, server|
        hash.merge!(key.to_sym => server.to_s)
      end
      hash
    end

    def execute_request
      open_server_rabbitmq
      @janus = Janus.new(@connection, @settings.options['queues'], @logs)
      yield
      @response
    end
  end
end
