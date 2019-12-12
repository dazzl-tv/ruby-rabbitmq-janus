# frozen_string_literal: true

module RubyRabbitmqJanus
  module Errors
    module Process
      module Event
        # Error for Process::Concurrencies::Event#initialize
        class Initializer < RubyRabbitmqJanus::Errors::Process::BaseEvent
          def initializer
            super 'Event', 'Error Event initializer'
          end
        end

        # Error for Process::Concurrencies::Event#run
        class Run < RubyRabbitmqJanus::Errors::Process::BaseEvent
          def initializer
            super 'Event', 'Error Event runner block code'
          end
        end
      end
    end
  end
end
