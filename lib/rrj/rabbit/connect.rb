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
      def transaction_short
        raise Errors::Rabbit::Connect::MissingAction unless block_given?

        response = transaction_long { yield }
        close
        response
      end

      # Create an transaction with rabbitmq and not close
      def transaction_long
        raise Errors::Rabbit::Connect::MissingAction unless block_given?

        Timeout.timeout(10) do
          start
          yield
        end
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
        Tools::Config.instance.server_settings.merge(connection_timeout: 5)
      end
    end
  end
end
