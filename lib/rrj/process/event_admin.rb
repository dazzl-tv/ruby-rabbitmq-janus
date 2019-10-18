# frozen_string_literal: true

module RubyRabbitmqJanus
  module Process
    module Concurrencies
      # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
      #
      # # Listen admin queue to all Janus instance
      #
      # Listen admin queue and sending a block code to thread listen.
      # The default queue is configured in config file.
      #
      # @see file:/config/default.md For more information to config file used.
      class EventAdmin < Concurrency
        include Singleton

        NAME_VAR = :publish_adm

        def initialize
          super
          @thread = Thread.new { initialize_thread }
        rescue
          raise Errors::Process::Event::Initializer
        end

        # Create a thread for execute a block code in a thread
        #
        # @param [Proc] block Block code for execute action when queue
        #   standard 'from-janus' receive a message.This block is sending to
        #   publisher created for this thread.
        #
        # @return [Thread] It's a thread who listen queue and execute action
        def run(&block)
          @thread.join
          Thread.new do
            loop do
              @thread.thread_variable_get(NAME_VAR).listen_events(&block)
            end
          end
        rescue
          raise Errors::Process::Event::Run
        end

        private

        def transaction_running
          publisher = Rabbit::Listener::FromAdmin.new(rabbit)
          @thread.thread_variable_set(NAME_VAR, publisher)
        end
      end
    end
  end
end
