# frozen_string_literal: true

module RubyRabbitmqJanus
  # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
  module Janus
    # For listen standard queue ("from-janus" by default)
    class Event < Thread
      include Singleton

      # Initialize Event object. Is used for listen an standard out queue to Janus
      def initialize
        super
        Tools::Log.instance.debug 'Start listen events in from-janus queue'
      end

      # Start listen queue and return each message
      def start_listen
        Thread.new do
          begin
            start_transaction
          rescue Interrupt
            Tools::Log.instance.info 'Stop to listen standard queue'
            rabbit.close
          end
        end
      end

      private

      # Strat a transaction with Rabbit an Janus
      def start_transaction
        rabbit.transaction_long do
          publisher = Rabbit::PublishListen.new(rabbit)
          publisher.listen_events
        end
      end
    end
  end
end
