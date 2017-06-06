# frozen_string_literal: true

module RubyRabbitmqJanus
  module Errors
    module Janus
      # Define a super class for Janus::Responses::ResponseStandard
      class BaseResponseStandard < BaseResponse
        def initialize(message, level = :fatal)
          super "[Response] #{message}", level
        end
      end

      module ResponseStandard
        # Error for Janus::Responses::ResponseStandard#initialize
        class Session < BaseResponseStandard
          def initialize
            super 'Error reading response session (data_id in response)'
          end
        end

        # Error for Janus::Responses::ResponseStandard#session_id
        class SessionId < BaseResponseStandard
          def initialize
            super 'Error reading response session_id'
          end
        end

        # Error for Janus::Responses::ResponseStandard#plugin
        class Plugin < BaseResponseStandard
          def initialize
            super 'Error reading response plugin'
          end
        end

        # Error for Janus::Responses::ResponseStandard#plugin_data
        class PluginData < BaseResponseStandard
          def initialize
            super 'Error reading response plugin data'
          end
        end

        # Error for Janus::Responses::ResponseStandard#data
        class Data < BaseResponseStandard
          def initialize
            super 'Error reading response data'
          end
        end

        # Error for Janus::Responses::ResponseStandard#sdp
        class SDP < BaseResponseStandard
          def initialize
            super 'Error reading SDP (jsep > sdp in response)'
          end
        end
      end
    end
  end
end
