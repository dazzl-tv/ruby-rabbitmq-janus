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

        # Create a thread for execute a block code in a thread
        #
        # @param [Proc] block Block code for execute action when queue
        #   standard 'from-janus' receive a message.This block is sending to
        #   publisher created for this thread.
        #
        # @return [Thread] It's a thread who listen queue and execute action
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
