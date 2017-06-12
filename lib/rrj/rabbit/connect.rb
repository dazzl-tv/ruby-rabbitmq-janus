# frozen_string_literal: true

module RubyRabbitmqJanus
  module Rabbit
    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
    #
    # Class for manage connection with RabbitMQ
    class Connect
      # Initialize connection to server RabbitMQ
      def initialize
        @rabbit = Bunny.new(read_options_server.merge!(option_log_rabbit))
      rescue
        raise Errors::Rabbit::Connect::Initialize
      end

      # Create an transaction with rabbitmq and close after response is received
      def transaction_short
        response = transaction_long { yield }
        close
        response
      rescue
        raise Errors::Rabbit::Connect::TransactionShort
      end

      # Create an transaction with rabbitmq and not close
      def transaction_long
        start
        yield
      rescue
        raise Errors::Rabbit::Connect::TransactionLong
      end

      # Openning a connection with Rabbitmq
      def start
        @rabbit.start
      rescue
        raise Errors::Rabbit::Start
      end

      # Close connection to server RabbitMQ
      def close
        @rabbit.close
      rescue
        raise Errors::Rabbit::Close
      end

      # Create an channel
      def channel
        @rabbit.create_channel
      rescue
        raise Errors::Rabbit::Channel
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
        {
          log_level: Tools::Config.instance.log_level_rabbit,
          log_file: Tools::Log.instance.logdev
        }
      end
    end
  end
end
