# frozen_string_literal: true

# @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>

module RubyRabbitmqJanus
  module Errors
    # Define errors to message sending and response to janus
    module Janus
      # Define a super class for all error in Janus::MessageAdmin
      class BaseMessageAdmin < BaseMessage
        def initialize(message, level = :fatal)
          super "[Admin] #{message}", level
        end
      end

      module MessageAdmin
        # Error Janus::MessageAdmin#initialize
        class Initializer < BaseMessageAdmin
          def initialize
            super 'Error in initializer'
          end
        end

        # Error Janus::MessageAdmin#options
        class Options < BaseMessageAdmin
          def initialize
            super 'Return properties message admin failed'
          end
        end
      end
    end
  end
end