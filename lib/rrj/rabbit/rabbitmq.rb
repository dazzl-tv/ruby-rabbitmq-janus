# frozen_string_literal: true

module RubyRabbitmqJanus
  # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
  # Class for connection with RabbitMQ Server
  class RabbitMQ
    # Return a new instance to RabbitMQ
    def initialize
      @connection = Rabbit::Connect.new
      @janus, @response = nil
    end

    # Connect to server RabbitMQ and post a message in queue ('to-janus' by default)
    def ask_request_sync(request_type, opts)
      execute_request do
        rqt = Requests.instance.requests[request_type.to_s]
        @response = ResponseError.new(@janus.send(rqt, opts))
        close_server_rabbitmq
      end
      @response.request
    end

    # Connect to server RabbitMQ and post a message in queue specific
    def ask_request_async(request_type, opts)
      execute_request do
        rqt = Requests.instance.requests[request_type.to_s]
        @response = ResponseError.new(@janus.send_async(rqt, opts))
        close_server_rabbitmq
      end
      @response.request
    end

    # Connect to server RabbitMQ and read a message in queue ('from-janus' by default)
    def ask_response(info_request)
      execute_request do
        @response = ResponseError.new(@janus.read(info_request, @connection.rabbit))
      end
      @response.request
    end

    private

    # Close connection to rabbitmq server
    def close_server_rabbitmq
      @connection.close
    rescue
      raise Bunny::ConnectionClosedError
    end

    # Execute request
    def execute_request
      @janus = Janus.new(@connection.rabbit)
      yield
      raise RubyRabbitmqJanus::ErrorRabbit::RequestNotExecuted \
        @response if @response.test_request_return
    end
  end
end
