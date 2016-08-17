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
      start_communication
    end

    # @deprecated
    def listen
      @connection.start
      begin
        @janus.listen_queue
      rescue Interrupt => _
        @connection.close
      end
    end

    private

    # @deprecated
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

    # @deprecated
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
