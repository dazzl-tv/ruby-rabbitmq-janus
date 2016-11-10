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
        super
        listen_live
      end

      # Start listen queue and return each message
      def listen(&block)
        initialize_thread(&block)
        # @lock.synchronize { condition.wait(lock) }
        # Tools::Log.instance.info "[x] Response : #{@response}"
        # yield @response
      end

      private

      # Listen q queue "from-janus"
      def listen_live
        # start_thread
        initialize_thread(&block)
      end

      # Intialize an listen to queue
      def initialize_thread(&block)
        start_transaction(&block)
      rescue Interrupt
        Tools::Log.instance.info 'Stop to listen standard queue'
        rabbit.close
      end

      # Start a transaction with Rabbit an Janus
      def start_transaction(&block)
        rabbit.transaction_long do
          publisher = Rabbit::Publisher::Listener.new(rabbit)
          publisher.listen_events
          loop do
            publisher.event_received(&block)
          end
        end
      end
    end
  end
end
