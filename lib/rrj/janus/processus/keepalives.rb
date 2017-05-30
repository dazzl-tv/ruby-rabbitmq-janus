# frozen_string_literal: true

module RubyRabbitmqJanus
  module Janus
    module Concurrencies
      class Keepalives < Concurrency
        include Singleton

        def initialize
          @pub = @session = nil
          @lock = Mutex.new
          @condition = ConditionVariable.new
          @threads = []
        end

        def create_session
          Tools::Log.instance.debug 'Create ONE session'
          @number_session = 0
          @threads.push(Thread.new do
            @lock.synchronize { @condition.signal }
            @number_session = Janus::Concurrencies::Keepalive.instance.session
          end)
        end

        def last_session
          @lock.synchronize do
            @condition.wait(@lock)
            @number_session
          end
        end

        private

        attr_reader :number_session
      end
    end
  end
end
