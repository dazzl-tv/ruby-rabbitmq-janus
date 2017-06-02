# frozen_string_literal: true

module RubyRabbitmqJanus
  module Errors
    module Janus
      class BaseResponseStandard < RubyRabbitmqJanus::Errors::Janus::BaseResponse
        def initialize(message, level = :fatal)
          super "[Response] #{message}", level
        end
      end

      module ResponseStandard
        class Session < RubyRabbitmqJanus::Errors::Janus::BaseResponseStandard
          def initialize
            super 'Error reading response session (data_id in response)'
          end
        end

        class SessionId < RubyRabbitmqJanus::Errors::Janus::BaseResponseStandard
          def initialize
            super 'Error reading response session_id'
          end
        end

        class Plugin < RubyRabbitmqJanus::Errors::Janus::BaseResponseStandard
          def initialize
            super 'Error reading response plugin'
          end
        end

        class PluginData < RubyRabbitmqJanus::Errors::Janus::BaseResponseStandard
          def initialize
            super 'Error reading response plugin data'
          end
        end

        class Data < RubyRabbitmqJanus::Errors::Janus::BaseResponseStandard
          def initialize
            super 'Error reading response data'
          end
        end

        class SDP < RubyRabbitmqJanus::Errors::Janus::BaseResponseStandard
          def initialize
            super 'Error reading SDP (jsep > sdp in response)'
          end
        end
      end
    end
  end
end
