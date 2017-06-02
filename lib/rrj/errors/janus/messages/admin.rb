# frozen_string_literal: true

# @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>

module RubyRabbitmqJanus
  module Errors
    # Define errors to message sending and response to janus
    module Janus
      class BaseMessageAdmin < BaseMessage
        def initialize(message, level = :fatal)
          super "[Admin] #{message}", level
        end
      end

      module MessageAdmin
        class Initializer < RubyRabbitmqJanus::Errors::Janus::BaseMessageAdmin
          def initialize
            super 'Error in initializer'
          end
        end

        class Option < RubyRabbitmqJanus::Errors::Janus::BaseMessageAdmin
          def initialize
            super 'Return properties message admin failed'
          end
        end
      end
    end
  end
end
