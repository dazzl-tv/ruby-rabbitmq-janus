# frozen_string_literal: true

require 'timeout'

module RubyRabbitmqJanus
  module Rabbit
    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
    #
    # Class for manage connection with RabbitMQ
    class Connect
      # Initialize connection to server RabbitMQ
      def initialize
        @rabbit = Bunny.new(bunny_conf)
      end

      # Create an transaction with rabbitmq and close after response is received
      def transaction_short(&block)
        raise RubyRabbitmqJanus::Errors::Connect::MissingAction unless block

        response = nil

        Timeout.timeout(5) do
          response = transaction_long(&block)
        end
      rescue Timeout::Error
        raise RubyRabbitmqJanus::Errors::Connect::TransactionTimeout, \
              'The "Short transaction" have raised Timeout exception.'
      ensure
        close
        response
      end

      # Create an transaction with rabbitmq and not close
      def transaction_long
        raise RubyRabbitmqJanus::Errors::Connect::MissingAction unless block_given?

        Timeout.timeout(60) do
          start
          yield
        end
      rescue Timeout::Error
        raise RubyRabbitmqJanus::Errors::Connect::TransactionTimeout, \
              'The "Long transaction" have raised Timeout exception.'
      end

      # Opening a connection with RabbitMQ
      def start
        @rabbit.start
      end

      # Close connection to server RabbitMQ
      def close
        @rabbit.close
      end

      # Create an channel
      def channel
        @rabbit.create_channel
      end

      private

      def bunny_conf
        Tools::Config.instance.server_settings.merge(bunny_conf_static)
      end

      def bunny_conf_static
        {
          connection_timeout: 5,
          connection_name: "[#{rand(999)}] backend",
          recover_from_connection_close: false
        }
      end
    end
  end
end
