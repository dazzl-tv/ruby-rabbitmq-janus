# frozen_string_literal: true

module RubyRabbitmqJanus
  module Process
    # Modules for create autonomous process
    module Concurrencies
      # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
      #
      # # Class for manage threads
      #
      # @abstract Manage thread for listener to queue :
      #   from-janus
      #   from-janus-admin
      class Concurrency
        # Initialize class with elements for thread communication
        def initialize
          ::Log.info info_thread
          @rabbit = RubyRabbitmqJanus::Rabbit::Connect.new
          @lock = Mutex.new
          @condition = ConditionVariable.new
        end

        private

        attr_reader :lock, :condition, :rabbit

        def initialize_thread
          @rabbit.transaction_long { transaction_running }
        rescue Interrupt
          ::Log.warn "This process has been interupted #{self.class.name}"
          ::Log.warn \
            "Close a connection with RabbitMQ instance for #{self.class.name}"
          @rabbit.close
        end

        def info_thread
          "Create an thread -- #{self.class.name}"
        end
      end
    end
  end
end

require 'rrj/process/event'
require 'rrj/process/event_admin'
