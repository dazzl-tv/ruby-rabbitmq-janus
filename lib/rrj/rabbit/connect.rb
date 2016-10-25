# frozen_string_literal: true

module RubyRabbitmqJanus
  module Rabbit
    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
    # Class for manage connection with rabbitmq
    class Connect
      # Initialize connection to server RabbitMQ
      def initialize
        Tools::Log.instance.debug 'Initialize connection with RabbitMQ'
        @rabbit = Bunny.new(read_options_server)
      end

      # Create and transaction between gem and rabbitmq
      def transaction
        start
        response = yield(self)
        close
        response
      end

      # Openning a connection with Rabbitmq
      def start
        Tools::Log.instance.debug 'Connection to rabbitmq START'
        @rabbit.start
      rescue => message
        raise Errors::ConnectionRabbitmqFailed, message
      end

      # Close connection to server RabbitMQ
      def close
        Tools::Log.instance.debug 'Connection to rabbitmq STOP'
        @rabbit.close
      rescue
        raise Bunny::ConnectionClosedError
      end

      # Create an channel
      def channel
        Tools::Log.instance.debug 'Create an channel'
        @rabbit.create_channel
      end

      private

      # Read option for bunny instance (connection with rabbitmq)
      # :reek:FeatureEnvy
      def read_options_server
        cfg = Tools::Config.instance.options['rabbit']
        {
          host: cfg['host'],
          port: cfg['port'],
          user: cfg['user'],
          pass: cfg['password'],
          vhost: cfg['vhost']
        }.merge!(option_log_rabbit)
      end

      def option_log_rabbit
        if Tools::Log.instance.level.zero?
          {
            log_level: Tools::Log.instance.level,
            log_file: Tools::Log.instance.logdev
          }
        else
          {}
        end
      end
    end
  end
end
