# frozen_string_literal: true

module RubyRabbitmqJanus
  module Rabbit
    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
    # Class for manage connection with rabbitmq
    # @!attribute [r] rabbit
    #   @return [Bunny#session] Represent AMQP connection
    class Connect
      attr_reader :rabbit

      # Initialize connection to server RabbitMQ
      def initialize
        @rabbit = Bunny.new(read_options_server)
        @rabbit.start
      rescue => message
        raise ErrorRabbit::ConnectionRabbitmqFailed, message
      end

      # Close connection to server RabbitMQ
      def close
        @rabbit.close
      rescue
        raise Bunny::ConnectionClosedError
      end

      private

      def read_options_server
        cfg = Config.instance.options['server']
        {
          host: cfg['host'],
          port: cfg['port'],
          user: cfg['user'],
          pass: cfg['password'],
          vhost: cfg['vhost'],
          logger: Log.instance.logger
        }
      end
    end
  end
end
