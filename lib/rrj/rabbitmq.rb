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
    end

    def send(request_type)
      open_server_rabbitmq
      @janus = Janus.new(@connection, @settings.options['queues'], @logs)
      @janus.send(@requests[request_type.to_s])
      close_server_rabbitmq
    end

    # Sending a message with opening and closing connection to RabbitMQ server
    def send_message(type)
      # Open connection to RabbitMQ server
      open_server_rabbitmq
      # Create object for creating message JSON
      @janus = Janus.new(@connection, @settings.options['queues'], @logs)
      # Execute sending message
      @janus.send_message(type)
      # Closing connection to RabbitMQ server
      close_server_rabbitmq
      # Return information to message sending
      type.information
    end

    # Reading a message with opening and closing connection to RabbitMQ server
    def read_message(type)
      # Open connection to RabbitMQ server
      open_server_rabbitmq
      # Create object for creating message JSON
      @janus = Janus.new(@connection, @settings.options['queues'], @logs)
      # Execute sending message
      msg = @janus.read_message(type)
      # Closing connection to RabbitMQ server
      close_server_rabbitmq
      # Return a response to message
      msg
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
  end
end
