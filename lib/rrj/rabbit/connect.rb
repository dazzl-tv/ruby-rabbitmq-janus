# frozen_string_literal: true

module RubyRabbitmqJanus
  # Module rabbit interaction
  module Rabbit
    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
    # Class for manage connection with rabbitmq
    class Connect
      # Initialize connection to server RabbitMQ
      def initialize
        Log.instance.debug 'Initialize connection with RabbitMQ'
        @rabbit = Bunny.new(read_options_server)
      end

      # Create and transaction betwwen gem and rabbitmq
      def transaction
        start
        response = yield(self)
        close
        response
      end

      # Openning a connection with Rabbitmq
      def start
        Log.instance.debug 'Connection to rabbitmq START'
        @rabbit.start
      rescue => message
        raise ErrorRabbit::ConnectionRabbitmqFailed, message
      end

      # Close connection to server RabbitMQ
      def close
        Log.instance.debug 'Connection to rabbitmq STOP'
        @rabbit.close
      rescue
        raise Bunny::ConnectionClosedError
      end

      # Create an channel
      def channel
        Log.instance.debug 'Create an channel'
        @rabbit.create_channel
      end

      private

      # Read option for bunny instance (connection with rabbitmq)
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
