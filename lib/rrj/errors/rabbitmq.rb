# frozen_string_literal: true

module RubyRabbitmqJanus
  module ErrorRabbitmq
    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
    # Define errors with Rabbitmq when request is not sending
    class RequestNotExecuted < RRJError
      def initialize(request)
        super "Error in request executed : #{request}", :error
      end
    end

    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
    # Define errors with Rabbitmq when connection is failed
    class ConnectionRabbitmqFailed < RRJError
      def initialize
        super 'Error to server connection', :fatal
      end
    end
  end
end
