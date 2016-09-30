# frozen_string_literal: true

module RubyRabbitmqJanus
  module ErrorRabbitmq
    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
    # Define errors with Rabbitmq when request is not sending
    class RequestNotExecuted < RRJError
      def initialize(request)
        @message = "Error in request executed : #{request}"
        @level = :warn
      end
    end

    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
    # Define errors with Rabbitmq when connection is failed
    class ConnectionRabbitmqFailed
      def initialize
        @message = 'Error to server connection'
        @level = :fatal
      end
    end
  end
end
