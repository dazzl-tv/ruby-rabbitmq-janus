# frozen_string_literal: true
# :reek:InstanceVariableAssumption and :reek:NilCheck
# :reek:TooManyInstanceVariables and :reek:TooManyStatements

module RubyRabbitmqJanus
  # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
  module Janus
    module Concurrencies
      # For listen standard queue ("from-janus" by default)
      class Event < Concurrency
        include Singleton

        # Initialize Event object. Is used for listen an standard out queue to
        # Janus
        def initialize
          super
          @publish = @response = nil
        end

        # Execute an block code in a thread
        def run(&block)
          @thread.join
          Thread.new do
            loop { @thread.thread_variable_get(:publish).listen_events(&block) }
          end
        end

        private

        # Initialize a thread
        def transaction_running
          publisher = Rabbit::Publisher::Listener.new(rabbit)
          Thread.current.thread_variable_set(:publish, publisher)
        end
      end
    end
  end
end
