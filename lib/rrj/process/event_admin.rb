# frozen_string_literal: true

# :reek:InstanceVariableAssumption

module RubyRabbitmqJanus
  module Process
    module Concurrencies
      # Manage admin message in queue public
      # Work In Progress
      class EventAdmin < Event
        include Singleton

        NAME_VAR = :publish_adm

        private

        def transaction_running
          publisher = Rabbit::Publisher::ListenerAdmin.new(rabbit)
          @thread.thread_variable_set(NAME_VAR, publisher)
        end
      end
    end
  end
end
