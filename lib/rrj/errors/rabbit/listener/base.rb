# frozen_string_literal: true

# :reek:IrresponsibleModule

module RubyRabbitmqJanus
  module Errors
    module Rabbit
      module Listener
        class BaseError < BaseRabbit
          def initialize(message, level = :fatal)
            super("[Listener] #{message}", level)
          end
        end

        module Base
          class Initialize < RubyRabbitmqJanus::Errors::Rabbit::Listener::BaseError
            def initialize
              super 'Error in initialize'
            end
          end

          class ListenEvents < RubyRabbitmqJanus::Errors::Rabbit::Listener::BaseError
            def initialize
              super "Error when listen events to queue 'janus-instance-thread'"
            end
          end
        end
      end
    end
  end
end
