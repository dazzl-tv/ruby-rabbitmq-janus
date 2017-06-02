# frozen_string_literal: true

# @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
# @see RubyRabbitmqJanus::Janus::Keepalive Keepalive thread

module RubyRabbitmqJanus
  module Errors
    module Janus
      class BaseResponseEvent < RubyRabbitmqJanus::Errors::Janus::BaseResponse
        def initialize(message)
          super "[Event] #{message}"
        end
      end

      module ResponseEvent
        class Event < RubyRabbitmqJanus::Errors::Janus::BaseResponseEvent
          def initializer
            super 'Error janus information reading'
          end
        end

        class Data < RubyRabbitmqJanus::Errors::Janus::BaseResponseEvent
          def initializer
            super 'Error plugin data information reading'
          end
        end

        class Jsep < RubyRabbitmqJanus::Errors::Janus::BaseResponseEvent
          def initializer
            super 'Error JSEP information reading'
          end
        end

        class Keys < RubyRabbitmqJanus::Errors::Janus::BaseResponseEvent
          def initializer
            super 'Error session_id and sender information reading'
          end
        end
      end
    end
  end
end
