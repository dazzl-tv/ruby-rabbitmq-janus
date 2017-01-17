# frozen_string_literal: true

module RubyRabbitmqJanus
  module Errors
    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
    # Define errors if connection to rabbitmq is failed
    class ConnectionRabbitmqFailed < RRJError
      # Initialize a error for rabbit module. It's a fatal error
      # @param [String] message Text returning in raise
      def initialize(message)
        super message, :fatal
      end
    end

    # Execpetion primary for Rabbit class
    class Rabbit < RRJError
      def initialize(message)
        super "[Rabbit]#{message}", :fatal
      end
    end

    # Send exception when publish a message to rabbitmq failed
    class RabbitPublishMessage < Rabbit
      def initialize(message, request)
        super "[Publish] #{message} -- #{request}"
      end
    end
  end
end
