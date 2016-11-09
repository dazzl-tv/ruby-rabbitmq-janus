# frozen_string_literal: true

require 'rrj/janus/threads/keepalive'
require 'rrj/janus/threads/event'

module RubyRabbitmqJanus
  module Janus
    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
    # Abstract class for janus Event and Keepalive
    class Thread
      include Singleton

      # Initialize class with elements for thread communication
      def initialize
        @rabbit = Rabbit::Connect.new
        @lock = Mutex.new
        @condition = ConditionVariable.new
      end
    end
  end
end
