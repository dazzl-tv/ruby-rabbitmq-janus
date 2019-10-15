# frozen_string_literal: true

module RubyRabbitmqJanus
  module Errors
    module Process
      # Define a super class for all error in Process::Concurency::Event class
      class BaseEvent < RubyRabbitmqJanus::Errors::Process::BaseConcurency
        def initialize(message)
          super "[Event] #{message}"
        end
      end

      module Event
        # Error for Process::Concurency::Event#initialize
        class Initializer < RubyRabbitmqJanus::Errors::Process::BaseEvent
          def initializer
            super 'Error Event initializer'
          end
        end

        # Error for Process::Concurency::Event#run
        class Run < RubyRabbitmqJanus::Errors::Process::BaseEvent
          def initializer
            super 'Error running block code'
          end
        end
      end
    end
  end
end
