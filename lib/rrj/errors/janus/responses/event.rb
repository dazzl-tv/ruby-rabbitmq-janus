# frozen_string_literal: true

# @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>

module RubyRabbitmqJanus
  module Errors
    module Janus
      # Define a super class for all error in Janus::Responses::ResponseEvent
      class BaseResponseEvent < RubyRabbitmqJanus::Errors::Janus::BaseResponse
        def initialize(message)
          super "[Event] #{message}"
        end
      end

      module ResponseEvent
        # Error for Janus::Responses::ResponseEvent#initialize
        class Event < RubyRabbitmqJanus::Errors::Janus::BaseResponseEvent
          def initializer
            super 'Error janus information reading'
          end
        end

        # Error for Janus::Responses::ResponseEvent#data
        class Data < RubyRabbitmqJanus::Errors::Janus::BaseResponseEvent
          def initializer
            super 'Error plugin data information reading'
          end
        end

        # Error for Janus::Responses::ResponseEvent#jsep
        class Jsep < RubyRabbitmqJanus::Errors::Janus::BaseResponseEvent
          def initializer
            super 'Error JSEP information reading'
          end
        end

        # Error for Janus::Responses::ResponseEvent#keys
        class Keys < RubyRabbitmqJanus::Errors::Janus::BaseResponseEvent
          def initializer
            super 'Error session_id and sender information reading'
          end
        end
      end
    end
  end
end
