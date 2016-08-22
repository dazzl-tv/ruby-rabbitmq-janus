# frozen_string_literal: true

require 'bunny'

module RRJ
  # Class for connection with RabbitMQ Server
  # @!attribute [r] connection
  #   @return [Bunny::Session]
  #   @see http://www.rubydoc.info/github/ruby-amqp/bunny/Bunny/Session
  # @!attribute [r] logs
  #   @return [RRJ::Log] Object Log for manipulate logs in gem
  # @!attribute [r] settings
  #   @return [RRJ::Config] Object Config to gem
  # @!attribute [r] queue
  #   @return [Bunny::Queue]
  #   @see http://www.rubydoc.info/github/ruby-amqp/bunny/Bunny/Queue
  # @!attribute [r] channel
  #   @return [Bunny::Channel]
  #   @see http://www.rubydoc.info/github/ruby-amqp/bunny/Bunny/Channel
  # @!attribute [r] janus
  #   @return [RRJ::Janus] Object for manipulate janus data
  class RabbitMQ
    attr_reader :connection, :logs, :settings, :queue, :channel, :janus, :response

    # Return a new instance to RabbitMQ
    # @param configuration [RRJ::Config] Configuration file to gem
    # @param logs [RRJ::Log] Log to gem
    def initialize(configuration, logs)
      @settings = configuration
      @logs = logs
      @connection = Bunny.new(read_options_server)
    end

    # Sending a message with opening and closing connection to RabbitMQ server
    def send_message(type)
      # Open connection to RabbitMQ server
      open_server_rabbitmq
      # Create object for creating message JSON
      @janus = Janus.new(@connection, @logs)
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
      @janus = Janus.new(@connection, @logs)
      # Execute sending message
      msg = @janus.read_message(type)
      # Closing connection to RabbitMQ server
      close_server_rabbitmq
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
