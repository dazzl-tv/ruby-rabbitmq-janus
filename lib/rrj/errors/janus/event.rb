# frozen_string_literal: true


module RubyRabbitmqJanus
  module Errors
    module Janus
      class BaseEvent < RubyRabbitmqJanus::Errors::Janus::BaseConcurency
        def initialize(message)
          super "[Event] #{message}"
        end
      end

      module Event
        class Initializer < RubyRabbitmqJanus::Errors::Janus::BaseEvent
          def initializer
            super 'Error Event initializer'
          end
        end

        class Run < RubyRabbitmqJanus::Errors::Janus::BaseEvent
          def initializer
            super 'Error running block code'
          end
        end
      end
    end
  end
end
