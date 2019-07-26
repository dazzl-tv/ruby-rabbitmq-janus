# frozen-string_literal: true

module RubyRabbitmqJanus
  module Errors
    module Rabbit
      class Event < BaseRabbit
        def initialize(message, level = :fatal)
          super("[Connect] #{message}", level)
        end
      end

      module BaseEvent
        class Initialize < RubyRabbitmqJanus::Errors::Rabbit::Event
          def initialize
            super 'Error in intializer BaseEvent'
          end
        end
      end
    end
  end
end
