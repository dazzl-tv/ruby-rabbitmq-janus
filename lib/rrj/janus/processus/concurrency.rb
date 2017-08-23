# frozen_string_literal: true

module RubyRabbitmqJanus
  module Janus
    # Modules for create autonomous processus
    module Concurrencies
      # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
      #
      # # Class for manage threads
      #
      # @abstract Manage thread in this gem for keepalive message and listen
      #   standard queue.
      class Concurrency
        # Initialize class with elements for thread communication
        def initialize
          Tools::Log.instance.info info_thread
          @rabbit = RubyRabbitmqJanus::Rabbit::Connect.new
          @lock = Mutex.new
          @condition = ConditionVariable.new
        rescue
          raise Errors::Janus::Concurencies::Initializer
        end

        private

        def initialize_thread
          @rabbit.transaction_long { transaction_running }
        rescue Interrupt
          Tools::Log.instance.info "Stop transaction #{self.class.name}"
          @rabbit.close
        end

        def info_thread
          "Create an thread -- #{self.class.name}"
        end

        attr_reader :lock, :condition, :rabbit
      end
    end
  end
end

require 'rrj/janus/processus/keepalive/keepalive_initializer'
require 'rrj/janus/processus/event'
