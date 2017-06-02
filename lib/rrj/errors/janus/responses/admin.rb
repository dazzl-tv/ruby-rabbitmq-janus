# frozen_string_literal: true

# @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
# @see RubyRabbitmqJanus::Janus::Keepalive Keepalive thread

module RubyRabbitmqJanus
  module Errors
    module Janus
      class BaseResponseAdmin < RubyRabbitmqJanus::Errors::Janus::BaseResponse
        def initialize(message)
          super "[Admin] #{message}"
        end
      end

      module ResponseAdmin
        class Sessions < RubyRabbitmqJanus::Errors::Janus::BaseResponseAdmin
          def initializer
            super 'Error sessions information reading'
          end
        end

        class Handles < RubyRabbitmqJanus::Errors::Janus::BaseResponseAdmin
          def initializer
            super 'Error handles information reading'
          end
        end

        class Info < RubyRabbitmqJanus::Errors::Janus::BaseResponseAdmin
          def initializer
            super 'Error info information reading'
          end
        end
      end
    end
  end
end
