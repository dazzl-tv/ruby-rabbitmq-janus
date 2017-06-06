# frozen_string_literal: true

# @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>

module RubyRabbitmqJanus
  module Errors
    # Define errors to message sending and response to janus
    module Janus
      # Define a super class for all error in Janus::Message
      class BaseMessageStandard < BaseMessage
        def initialize(message, level = :fatal)
          super "[Standard] #{message}", level
        end
      end

      module MessageStandard
        # Error for Janus::MessageStandard#initialize
        class Initializer < BaseMessageStandard
          def initialize
            super 'Error in initializer'
          end
        end

        # Error for Janus::MessageStandard#option
        class Option < BaseMessageStandard
          def initialize
            super 'Return properties message admin failed'
          end
        end
      end
    end
  end
end
