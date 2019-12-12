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
      rescue => exception
        raise Errors::Rabbit::Connect::Initialize, exception
      end

      # Create an transaction with rabbitmq and close after response is received
      def transaction_short
        raise Errors::Rabbit::Connect::MissingAction unless block_given?

        response = transaction_long { yield }
        close
        response
      rescue => exception
        raise Errors::Rabbit::Connect::TransactionShort, exception
      end

      # Create an transaction with rabbitmq and not close
      def transaction_long
        raise Errors::Rabbit::Connect::MissingAction unless block_given?

        Timeout.timeout(10) do
          start
          yield
        end
      rescue => exception
        raise Errors::Rabbit::Connect::TransactionLong, exception
      end

      # Opening a connection with RabbitMQ
      def start
        @rabbit.start
      rescue => exception
        raise Errors::Rabbit::Connect::Start, exception
      end

      # Close connection to server RabbitMQ
      def close
        @rabbit.close
      rescue => exception
        raise Errors::Rabbit::Connect::Close, exception
      end

      # Create an channel
      def channel
        @rabbit.create_channel
      rescue => exception
        raise Errors::Rabbit::Connect::Channel, exception
      end

      private

      def bunny_conf
        Tools::Config.instance.server_settings.merge(connection_timeout: 5)
      end
    end
  end
end
