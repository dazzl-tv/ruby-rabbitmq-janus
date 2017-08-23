# frozen_string_literal: true

# :reek:TooManyStatements

module RubyRabbitmqJanus
  module Rabbit
    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
    #
    # Class for manage connection with RabbitMQ
    class Connect
      include Singleton

      # Initialize connection to server RabbitMQ
      def initialize
        @rabbit = Bunny.new(read_options_server.merge!(option_log_rabbit))
      rescue => error
        raise Errors::Rabbit::Connect::Initialize, error
      end

      # Create an transaction with rabbitmq and close after response is received
      def transaction_short
        response = transaction_long { yield }
        close
        response
      rescue => error
        raise Errors::Rabbit::Connect::TransactionShort, error
      end

      # Create an transaction with rabbitmq and not close
      def transaction_long
        start
        yield
      rescue => error
        raise Errors::Rabbit::Connect::TransactionLong, error
      end

      # Openning a connection with Rabbitmq
      def start
        @rabbit.start
      rescue => error
        raise Errors::Rabbit::Connect::Start, error
      end

      # Close connection to server RabbitMQ
      def close
        @rabbit.close
      rescue => error
        raise Errors::Rabbit::Connect::Close, error
      end

      # Create an channel
      def channel
        @rabbit.create_channel
      rescue => error
        raise Errors::Rabbit::Connect::Channel, error
      end

      private

      def read_options_server
        cfg = Tools::Config.instance.options['rabbit']
        opts = {}
        %w[host port pass user vhost].each do |val|
          opts.merge!(val.to_sym => cfg[val])
        end
        opts
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
