# frozen_string_literal: true

require 'bunny-mock'

# :reek:FeatureEnvy

module RubyRabbitmqJanus
  module Rabbit
    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
    #
    # Override class connect with a Faker connection with rabbitmq
    class ConnectFake
      # Initialize connection to server RabbitMQ
      def initialize
        @rabbit = BunnyMock.new.start
      rescue => exception
        raise Errors::Rabbit::Connect::Initialize, exception
      end

      # Create an transaction with rabbitmq and close after response is received
      def transaction_short
        response = fake_transaction
        close
        response
      rescue => exception
        raise Errors::Rabbit::Connect::TransactionShort, exception
      end

      # Create an transaction with rabbitmq and not close
      def transaction_long
        start
        @rabbit.channel.queue.pop[:message]
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
        @rabbit.channel
      rescue => exception
        raise Errors::Rabbit::Connect::Channel, exception
      end

      private

      def fake_transaction
        channel = @rabbit.channel
        queue = channel.queue 'janus-queue-test'
        queue.publish 'RSpec testing message'
        queue.pop
      end
    end
  end
end
