# frozen_string_literal: true

require 'active_support/concern'

module RubyRabbitmqJanus
  module Process
    module Concurrencies
      # Module injected in Concurrencies classes.
      #
      # Manage threads for public/admin queue to rabbitmq.
      #
      # :reek:ModuleInitialize
      module ThreadRunnerConcern
        extend ActiveSupport::Concern

        included do
          # Initialize an process (event/event_admin) and configure
          # the life cycle to thread.
          def initialize
            super
            @thread = Thread.new { initialize_thread }
          end

          # Create a thread for execute a block code in a thread.
          # This code is outside to `RRJ` gem so is very important
          # to be sure this code execution is not fail.
          #
          # @param [Proc] block Block code for execute action when queue
          #   standard 'from-janus' receive a message.This block is sending to
          #   publisher created for this thread.
          #
          # @return [Thread] It's a thread who listen queue and execute action
          def run(&block)
            raise_nil_block unless block_given?

            @thread.join
            Thread.new do
              loop do
                @thread.thread_variable_get(name_publisher)
                       .listen_events(&block)
              rescue => exception
                ::Log.warn exception
              end
            end
          end

          private

          def transaction_running
            @thread.thread_variable_set(name_publisher, publisher)
          end
        end
      end
    end
  end
end
