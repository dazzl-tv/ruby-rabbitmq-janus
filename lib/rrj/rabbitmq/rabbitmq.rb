# frozen_string_literal: true

require 'bunny'

module RubyRabbitmqJanus
  # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
  # Class for connection with RabbitMQ Server
  class RabbitMQ
    # Return a new instance to RabbitMQ
    def initialize
      @connection = Bunny.new(read_options_server)
      @janus, @response = nil
    end

    # Connect to server RabbitMQ and post a message in queue ('to-janus' by default)
    def ask_request_sync(request_type, opts)
      execute_request do
        rqt = Requests.instance.requests[request_type.to_s]
        @response = @janus.send(rqt, opts)
        close_server_rabbitmq
      end
    end

    def ask_request_async(request_type, opts)
      execute_request do
        rqt = Requests.instance.requests[request_type.to_s]
        @response = @janus.send_async(rqt, opts)
        close_server_rabbitmq
      end
    end

    # Connect to server RabbitMQ and read a message in queue ('from-janus' by default)
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
    # This method smells of :reek:DuplicateMethodCall
    # This method smells of :reek:TooManyStatements
    # This method smells of :reek:FeatureEnvy
    def read_options_server
      hash = {}
      hash.merge!(define_options)
      hash['log_level'] = Log.instance.level
      hash['log_file'] = Log.instance.log_file
      hash
    end

    # This method smells of :reek:UtilityFunction
    def define_options
      hash = {}
      Config.instance.options.fetch('server').each do |key, server|
        hash[key.to_sym] = server.to_s
      end
      hash
    end

    # Execute request
    def execute_request
      open_server_rabbitmq
      @janus = Janus.new(@connection)
      yield
      @response
    end
  end
end
