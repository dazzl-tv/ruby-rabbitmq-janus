# frozen_string_literal: true

# :reek:TooManyStatements

module RubyRabbitmqJanus
  module Rabbit
    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
    #
    # Class for manage connection with RabbitMQ
    class Connect
      # Initialize connection to server RabbitMQ
      def initialize
        @rabbit = if RubyRabbitmqJanus::RRJ_RSPEC
                    BunnyMock.new.start
                  else
                    Bunny.new(read_options_server.merge!(option_log_rabbit))
                  end
      rescue => exception
        raise Errors::Rabbit::Connect::Initialize, exception
      end

      # Create an transaction with rabbitmq and close after response is received
      def transaction_short
        response = if RubyRabbitmqJanus::RRJ_RSPEC
                     fake_transaction
                   else
                     transaction_long { yield }
                   end
        close
        response
      rescue => exception
        raise Errors::Rabbit::Connect::TransactionShort, exception
      end

      # Create an transaction with rabbitmq and not close
      def transaction_long
        start
        if RubyRabbitmqJanus::RRJ_RSPEC
          @rabbit.channel.queue.pop[:message]
        else
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
        if RubyRabbitmqJanus::RRJ_RSPEC
          @rabbit.channel
        else
          @rabbit.create_channel
        end
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

      def read_options_server
        conn = %w[host port pass user vhost]
        cfg = Tools::Config.instance.options['rabbit']
        Hash[conn.map { |value| [value.to_sym, cfg[value]] }]
      end

      def option_log_rabbit
        lvl = Tools::Config.instance.log_level_rabbit.upcase.to_sym
        {
          log_level: Tools::Log::LEVELS[lvl],
          log_file: Tools::Log.instance.logdev
        }
      end
    end
  end
end
