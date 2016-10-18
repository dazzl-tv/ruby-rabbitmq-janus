# frozen_string_literal: true

module RubyRabbitmqJanus
  module Errors
    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
    # Define errors with Rabbitmq when request is not sending
    class RequestNotExecuted < Errors::RRJError
      def initialize(request)
        super "Error in request executed : #{request}", :error
      end
    end

    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
    # Define errors if connection to rabbitmq is failed
    class ConnectionRabbitmqFailed < Errors::RRJError
      def initialize(message)
        super message, :fatal
      end
    end
  end
end
