# frozen_string_literal: true
# :reek:TooManyInstanceVariables

module RubyRabbitmqJanus
  module Janus
    # Modules for create autonomous processus
    module Concurrencies
      # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>

      # # Class for manage threads
      #
      # @abstract Manage thread in this gem for keepalive message and listen
      # standard queue.
      class Concurrency
        # Initialize class with elements for thread communication
        def initialize
          Tools::Log.instance.info "Create an thread -- #{self.class.name}"
          @rabbit = Rabbit::Connect.new
          @lock = Mutex.new
          @condition = ConditionVariable.new
          @thread = Thread.new { initialize_thread }
          @publish = nil
        end

        private

        def initialize_thread
          @rabbit.transaction_long { transaction_running }
        rescue Interrupt
          Tools::Log.instance.info "Stop transaction #{self.class.name}"
          @rabbit.close
        end

        attr_accessor :rabbit, :publish
        attr_reader :thread, :lock, :condition
      end
    end
  end
end

require 'rrj/janus/processus/keepalive'
require 'rrj/janus/processus/event'
