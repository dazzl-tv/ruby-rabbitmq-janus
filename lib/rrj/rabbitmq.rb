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
    attr_reader :connection, :logs, :settings, :queue, :channel, :janus

    # Return a new instance to RabbitMQ
    # @param configuration [RRJ::Config] Configuration file to gem
    # @param logs [RRJ::Log] Log to gem
    def initialize(configuration, logs)
      @settings = configuration
      @logs = logs
    end

    # Send message
    def send_message
      open_server_rabbitmq
      @janus.send_message
      close_server_rabbitmq
    end

    # Listen queue
    def listen_queue
      open_server_rabbitmq
      @janus.listen_messages
      close_server_rabbitmq
    end

    private

    # Establish connection with RabbitMQ server
    # @return [RRJ::Janus] Janus object for manipulating data sending and receiving to
    #   rabbitmq server
    def open_server_rabbitmq
      @connection = Bunny.new(read_options_server)
      @connection.start
      @janus = Janus.new(@connection, @logs)
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
