# frozen_string_literal: true

module RubyRabbitmqJanus
  # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
  module Janus
    module Concurrencies
      # For listen standard queue ("from-janus" by default)
      class Event < Concurrency
        include Singleton

        # Initialize Event object. Is used for listen an standard out queue to Janus
        def initialize
          @publish = @response = nil
          super
        end

        # Start listen queue and work with each message reading
        def listen(&block)
          wait do
            Tools::Log.instance.info 'Action !!!'.red
            @publish.event_received(&block)
          end
        end

        private

        # Start a transaction with Rabbit an Janus
        def transaction_running
          @publish = Rabbit::Publisher::Listener.new(rabbit)
          @response = @publish.listen_events
          signal
        end
      end
    end
  end
end
