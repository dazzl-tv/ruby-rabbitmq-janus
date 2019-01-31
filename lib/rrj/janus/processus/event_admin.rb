# frozen_string_literal: true

module RubyRabbitmqJanus
  module Janus
    module Concurrencies
      class EventAdmin < Event
        include Singleton

        NAME_VAR = :publish_adm.freeze

        private

        def transaction_running
          publisher = Rabbit::Publisher::ListenerAdmin.new(rabbit)
          @thread.thread_variable_set(NAME_VAR, publisher)
        end
      end
    end
  end
end
