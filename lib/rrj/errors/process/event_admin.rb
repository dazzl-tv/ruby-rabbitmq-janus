# frozen_string_literal: true

module RubyRabbitmqJanus
  module Errors
    module Process
      module EventAdmin
        # Error for Process::Concurrencies::EventAdmin#initialize
        class Initializer < RubyRabbitmqJanus::Errors::Process::BaseEvent
          def initializer
            super 'EventAdmin', 'Error EventAdmin initializer'
          end
        end

        # Error for Process::Concurrencies::EventAdmin#run
        class Run < RubyRabbitmqJanus::Errors::Process::BaseEvent
          def initializer
            super 'EventAdmin', 'Error EventAdmin runner block code'
          end
        end
      end
    end
  end
end
