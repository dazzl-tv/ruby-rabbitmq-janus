# frozen_string_literal: true

module RubyRabbitmqJanus
  module Janus
    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
    # Abstract class for janus Event and Keepalive
    class OneThread
      # Initialize class with elements for thread communication
      def initialize
        @rabbit = Rabbit::Connect.new
        @lock = Mutex.new
        @condition = ConditionVariable.new
      end

      private

      def start_thread
        Thread.new { initialize_thread }
      end

      attr_accessor :rabbit, :lock, :condition
    end
  end
end

require 'rrj/janus/threads/keepalive'
require 'rrj/janus/threads/event'
