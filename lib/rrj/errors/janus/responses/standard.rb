# frozen_string_literal: true

module RubyRabbitmqJanus
  module Errors
    module Janus
      # Define a super class for Janus::Responses::ResponseStandard
      class BaseResponseStandard < BaseResponse
        def initialize(message, level = :fatal)
          super "[Response]#{message}", level
        end
      end

      module ResponseStandard
        class Session < BaseResponseStandard
          def initialize
            super '[Session] Error reading response session (data_id in response)'
          end
        end

        class SessionId < BaseResponseStandard
          def initialize
            super '[SessionId] Error reading response session_id'
          end
        end

        class Plugin < BaseResponseStandard
          def initialize
            super '[Plugin] Error reading response plugin'
          end
        end

        class PluginData < BaseResponseStandard
          def initialize
            super '[PluginData] Error reading response plugin data'
          end
        end

        class Data < BaseResponseStandard
          def initialize
            super '[Data] Error reading response data'
          end
        end

        class SDP < BaseResponseStandard
          def initialize
            super '[SDP] Error reading SDP (jsep > sdp in response)'
          end
        end
      end
    end
  end
end
