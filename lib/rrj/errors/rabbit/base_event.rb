# frozen-string_literal: true

# :reek:IrresponsibleModule

module RubyRabbitmqJanus
  module Errors
    module Rabbit
      # Error class for all Event
      class Event < BaseRabbit
        def initialize(message, level = :fatal)
          super("[Connect] #{message}", level)
        end
      end

      module BaseEvent
        # Error class for Rabbit BaseEvent
        class Initialize < RubyRabbitmqJanus::Errors::Rabbit::Event
          def initialize
            super 'Error in intializer BaseEvent'
          end
        end
      end
    end
  end
end
