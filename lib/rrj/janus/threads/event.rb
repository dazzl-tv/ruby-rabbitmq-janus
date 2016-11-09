# frozen_string_literal: true

module RubyRabbitmqJanus
  # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
  module Janus
    # For listen standard queue ("from-janus" by default)
    class Event < OneThread
      include Singleton

      # Initialize Event object. Is used for listen an standard out queue to Janus
      def initialize
        Tools::Log.instance.debug 'Start listen events in from-janus queue'
        super
        @response = nil
        listen_live
      end

      # Start listen queue and return each message
      def listen
        lock.synchronize do
          condition.wait(lock)
          Tools::Log.instance.debug \
            "Response finding in queue : #{@response.to_nice_json}"
        end
        @response
      end

      private

      # Listen q queue "from-janus"
      def listen_live
        start_thread
      end

      # Intialize an listen to queue
      def initialize_thread
        start_transaction
      rescue Interrupt
        Tools::Log.instance.info 'Stop to listen standard queue'
        rabbit.close
      end

      # Strat a transaction with Rabbit an Janus
      def start_transaction
        rabbit.transaction_long do
          publisher = Rabbit::PublishListen.new(rabbit)
          @response = publisher.listen_events
        end
      end
    end
  end
end
