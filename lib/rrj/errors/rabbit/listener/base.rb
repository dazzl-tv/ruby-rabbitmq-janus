# frozen_string_literal: true

module RubyRabbitmqJanus
  module Errors
    module Rabbit
      module Listener
        # Base class error for listeners
        class BaseError < BaseRabbit
          def initialize(message, level = :fatal)
            super("[Listener] #{message}", level)
          end
        end

        module Base
          # Error initializer for listeners
          class Initialize < RubyRabbitmqJanus::Errors::Rabbit::Listener::BaseError
            def initialize
              super 'Error in initialize'
            end
          end

          # Error listen event
          class ListenEvents < RubyRabbitmqJanus::Errors::Rabbit::Listener::BaseError
            def initialize(queue)
              super "Error when listen events to queue '#{queue}'"
            end
          end

          # Error when response is empty
          class ResponseEmpty < RubyRabbitmqJanus::Errors::Rabbit::Listener::BaseError
            def initialize(response)
              super "Response is empty ! (#{response})"
            end
          end

          # Error when response is nil
          class ResponseNil < RubyRabbitmqJanus::Errors::Rabbit::Listener::BaseError
            def initialize(response)
              super "Response is nil ! (#{response})"
            end
          end
        end
      end
    end
  end
end
