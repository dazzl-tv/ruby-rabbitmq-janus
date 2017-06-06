# frozen_string_literal: true

module RubyRabbitmqJanus
  module Errors
    module Janus
      # Define a super class for all error in Janus::Concurency::Event class
      class BaseEvent < RubyRabbitmqJanus::Errors::Janus::BaseConcurency
        def initialize(message)
          super "[Event] #{message}"
        end
      end

      module Event
        # Error for Janus::Concurency::Event#initialize
        class Initializer < RubyRabbitmqJanus::Errors::Janus::BaseEvent
          def initializer
            super 'Error Event initializer'
          end
        end

        # Error for Janus::Concurency::Event#run
        class Run < RubyRabbitmqJanus::Errors::Janus::BaseEvent
          def initializer
            super 'Error running block code'
          end
        end
      end
    end
  end
end
