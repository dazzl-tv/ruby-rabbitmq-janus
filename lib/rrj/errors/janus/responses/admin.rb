# frozen_string_literal: true

# @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>

module RubyRabbitmqJanus
  module Errors
    module Janus
      # Define a super class for all error in Janus::Responses::ResponseAdmin
      class BaseResponseAdmin < RubyRabbitmqJanus::Errors::Janus::BaseResponse
        def initialize(message)
          super "[Admin] #{message}"
        end
      end

      module ResponseAdmin
        # Error for Janus::Responses::ResponseAdmin#sessions
        class Sessions < RubyRabbitmqJanus::Errors::Janus::BaseResponseAdmin
          def initializer
            super 'Error sessions information reading'
          end
        end

        # Error for Janus::Responses::ResponseAdmin#handles
        class Handles < RubyRabbitmqJanus::Errors::Janus::BaseResponseAdmin
          def initializer
            super 'Error handles information reading'
          end
        end

        # Error for Janus::Responses::ResponseAdmin#info
        class Info < RubyRabbitmqJanus::Errors::Janus::BaseResponseAdmin
          def initializer
            super 'Error info information reading'
          end
        end
      end
    end
  end
end
