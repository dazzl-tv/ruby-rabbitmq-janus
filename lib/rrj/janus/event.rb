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
        begin
          start_transaction
        rescue Interrupt
          Tools::Log.instance.info 'Stop to listen standard queue'
          @rabbit.close
        end
        # end
      end

      private

      def start_transaction
        @rabbit.transaction_long do
          publisher = Rabbit::PublishNonExclusive.new(@rabbit.channel)
          publisher.listen_events
          # publish = Rabbit::PublishNonExclusive.new(@rabbit.channel)
          # loop_in_queue(publish.listen_events)
        end
      end

      def loop_in_queue(_event)
        # loop do
        #   Janus::Response.new(event)
        #   @lock.synchronize do
        #     @condition.wait(@lock)
        #     Janus::Response.new(event)
        #   end
        # end
      end
    end
  end
end
