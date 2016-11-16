# frozen_string_literal: true

module RubyRabbitmqJanus
  module Janus
    # Modules for create autonomous processus
    module Concurrencies
      # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
      # Abstract class for janus Event and Keepalive
      class Concurrency
        # Initialize class with elements for thread communication
        def initialize
          Tools::Log.instance.info "Create an thread -- #{self.class.name}"
          @rabbit = Rabbit::Connect.new
          @lock = Mutex.new
          @condition = ConditionVariable.new
          @thread = Thread.new { initialize_thread }
          @thread.abort_on_exception = true
        end

        private

        # Initialize a thread
        def initialize_thread
          rabbit.transaction_long { transaction_running }
        rescue Interrupt
          Tools::Log.instance.info "Stop transaction #{self.class.name}"
          rabbit.close
        end

        # Wait an signal
        def wait
          @lock.synchronize do
            @condition.wait(@lock)
            Tools::Log.instance.info 'Waitting signal'
            yield
          end
        end

        # Send and signal
        def signal
          @lock.synchronize do
            Tools::Log.instance.info 'Sending signal'
            @condition.signal
          end
        end

        attr_accessor :rabbit, :publish
      end
    end
  end
end

require 'rrj/janus/processus/keepalive'
require 'rrj/janus/processus/event'