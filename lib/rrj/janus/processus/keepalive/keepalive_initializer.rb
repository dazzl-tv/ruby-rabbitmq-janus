# frozen_string_literal: true

require 'rrj/janus/processus/keepalive/keepalive_timer'
require 'rrj/janus/processus/keepalive/keepalive_message'
require 'rrj/janus/processus/keepalive/keepalive_thread'

module RubyRabbitmqJanus
  module Janus
    module Concurrencies
      # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
      #
      # # Manage keepalive message
      #
      # Create a thread for sending a message with type keepalive to session
      # created by this instanciate gem
      class KeepaliveInitializer < Concurrency
        # Initialize a singleton object for sending keepalive to janus
        def initialize(instance)
          super()
          @thread = KeepaliveThread.new(instance, rabbit) { initialize_thread }
        rescue
          raise Errors::Janus::KeepaliveInitializer::Initializer
        end

        # Get thread with Ruby ID
        def self.thread(thread)
          ObjectSpace._id2ref(thread)
        rescue RangeError
          puts "No thread with ID : #{thread}"
        end

        # Give a session Integer  his gem is instantiate.
        # Is waiting a thread return a response to message created sending.
        #
        # @example Ask session
        #   KeepaliveInitializer.new(123, @rabbit).session
        #   => 852803383803249
        #
        # @return [Fixnum] Identifier to session created by Janus
        def session
          @thread.timer.session do
            lock.synchronize do
              condition.wait(lock)
              @thread.session
            end
          end
        rescue
          raise Errors::Janus::KeepaliveInitializer::Session
        end

        # Ask Object ID to thread managing keepalive message
        #
        # @example Ask ID
        #   KeepaliveInitializer.new(123, @rabbit).thread
        #   => 70233080652140
        #
        # @return [Integer] Identifier to thread in Ruby
        def thread_id
          @thread.__id__
        rescue
          raise Errors::Janus::KeepaliveInitializer::Thread
        end

        private

        def transaction_running
          @thread.initialize_janus_session
          lock.synchronize { condition.signal }
          @thread.start
        end
      end
    end
  end
end
