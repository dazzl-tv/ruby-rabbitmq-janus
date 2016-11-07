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
        Thread.new do
          begin
            start_transaction
          rescue Interrupt
            Tools::Log.instance.info 'Stop to listen standard queue'
            @rabbit.close
          end
        end
      end

      private

      def start_transaction
        @rabbit.transaction_long do
          publisher = Rabbit::PublishListen.new(@rabbit)
          publisher.listen_events
        end
      end
    end
  end
end
