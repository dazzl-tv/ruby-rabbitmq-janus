# frozen_string_literal: true

module RubyRabbitmqJanus
  module Rabbit
    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
    # Class for manage connection with rabbitmq
    # @!attribute [r] rabbit
    #   @return [Bunny#session] Represent AMQP connection
    class Connect
      # Initialize connection to server RabbitMQ
      def initialize
        @rabbit = Bunny.new(read_options_server)
      end

      # Create and transaction betwwen gem and rabbitmq
      def transaction
        start
        yield
        close
      end

      # Openning a connection with Rabbitmq
      def start
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

      # Create an channel
      def channel
        @rabbit.create_channel
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
