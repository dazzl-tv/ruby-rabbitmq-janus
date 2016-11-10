# frozen_string_literal: true

module RubyRabbitmqJanus
  module Janus
    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
    # Abstract class for janus Event and Keepalive
    class Concurrency
      # Initialize class with elements for thread communication
      def initialize
        Tools::Log.instance.info 'Create an subprocess'
        @rabbit = Rabbit::Connect.new
        @lock = Mutex.new
        @condition = ConditionVariable.new
      end

      private

      # Start a new thread
      def start_thread
        Thread.new { initialize_thread }
        # pid = fork { initialize_thread }
        # Tools::Log.instance.info "Process IDentifier : #{pid}"
        # initialize_thread
      end

      # Wait an signal
      def wait
        @lock.synchronize do
          @condition.wait(@lock)
          yield
        end
      end

      # Send and signal
      def signal
        @lock.synchronize { @condition.signal }
      end

      attr_accessor :rabbit, :publish
    end
  end
end

require 'rrj/janus/threads/keepalive'
require 'rrj/janus/threads/event'
