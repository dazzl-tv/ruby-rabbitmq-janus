# frozen_string_literal: true

module RubyRabbitmqJanus
  # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
  module Janus
    # For listen standard queue
    class Event
      include Singleton

      def initialize
        @response = nil
        @rabbit = Rabbit::Connect.new
        @lock = Mutex.new
        @condition = ConditionVariable.new
      end

      def start_listen
        # Thread.new do
        Tools::Log.instance.debug 'Start thread to listen queue from-janus'
        @rabbit.transaction_long do
          loop_in_queue(Rabbit::PublishNonExclusive.new(@rabbit.channel))
        end
        @rabbit.close
        # end
      end

      private

      def loop_in_queue(publish)
        loop do
          @lock.synchronize do
            @condition.wait(@lock)
            Janus::Response.new publish.listen_events
          end
        end
      end
    end
  end
end
