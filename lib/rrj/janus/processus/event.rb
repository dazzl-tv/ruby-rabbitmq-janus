# frozen_string_literal: true

module RubyRabbitmqJanus
  module Janus
    module Concurrencies
      # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>

      # # Listen standar queue
      #
      # Listen standard queue and sending a block code to thread listen.
      # The default queue is configured in config file.
      #
      # @see file:/config/default.md For more information to config file used.
      class Event < Concurrency
        include Singleton

        # Create a thred for execute a block code in a thread
        #
        # @yield Send to publisher the actions when a Janus event is received
        def run(&block)
          thread.join
          Thread.new do
            loop { thread.thread_variable_get(:publish).listen_events(&block) }
          end
        end

        private

        def transaction_running
          publisher = Rabbit::Publisher::Listener.new(rabbit)
          Thread.current.thread_variable_set(:publish, publisher)
        end
      end
    end
  end
end
