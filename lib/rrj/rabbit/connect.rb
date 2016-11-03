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

      # Create an transaction with rabbitmq and close after response is received
      def transaction_short
        response = transaction_long { yield }
        close
        response
      end

      # Create an transaction with rabbitmq and not close
      def transaction_long
        start
        yield
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
        opts = {}
        %w(host port pass user vhost).each do |val|
          opts.merge!(val.to_sym => Tools::Env.instance.test_env_var(cfg, val))
        end
        opts.merge!(option_log_rabbit)
      end

      # Define option logs for bunny
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
