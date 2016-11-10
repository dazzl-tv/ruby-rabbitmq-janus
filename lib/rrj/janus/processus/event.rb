# frozen_string_literal: true

module RubyRabbitmqJanus
  # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
  module Janus
    # For listen standard queue ("from-janus" by default)
    class Event < Concurrency
      include Singleton

      # Initialize Event object. Is used for listen an standard out queue to Janus
      def initialize
        Tools::Log.instance.debug 'Start listen events in from-janus queue'
        @publish = @response = nil
        super
        # start_thread
      end

      # Start listen queue and work with each message reading
      def listen(&block)
        fork do
          initialize_thread
          @publish.event_received(&block)
        end
      end

      private

      # Intialize an listen to queue
      def initialize_thread
        rabbit.transaction_long { start_transaction }
      rescue Interrupt
        Tools::Log.instance.info 'Stop to listen standard queue'
        rabbit.close
      end

      # Start a transaction with Rabbit an Janus
      def start_transaction
        @publish = Rabbit::Publisher::Listener.new(rabbit)
        @publish.listen_events
      end
    end
  end
end
