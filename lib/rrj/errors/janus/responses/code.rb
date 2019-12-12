# frozen_string_literal: true

module RubyRabbitmqJanus
  module Errors
    module Janus
      module Response
        class Nok < RubyRabbitmqJanus::Errors::BaseJanus
          def initialize(code, message)
            super "[#{code}] Error response : #{message}", :unknown
          end
        end

        class ResponseUnknown < Nok; end
        class ResponseNotAcceptingSession < Nok; end
        class ResponseWebRTCState < Nok; end
        class ResponseTokenNotFound < Nok; end
        class ResponseUnexpectedAnswer < Nok; end
        class ResponseSessionConflit < Nok; end
        class ResponseInvalidElementType < Nok; end
        class ResponseTrickleInvalidStream < Nok; end
        class ResponseJSEPInvalidSDP < Nok; end
        class ResponseJSEPUnknownType < Nok; end
        class ResponsePluginDetach < Nok; end
        class ResponsePluginMessage < Nok; end
        class ResponsePluginAttach < Nok; end
        class ResponsePluginNotFound < Nok; end
        class ResponseHandleNotFound < Nok; end
        class ResponseSessionNotFound < Nok; end
        class ResponseInvalidRequestPath < Nok; end
        class ResponseMissingMandatoryElement < Nok; end
        class ResponseInvalidJSONObject < Nok; end
        class ResponseInvalidJSON < Nok; end
        class ResponseUnknownRequest < Nok; end
        class ResponseMissingRequest < Nok; end
        class ResponseTransportSpecific < Nok; end
        class ResponseUnauthorizedPlugin < Nok; end
        class ResponseUnauthorized < Nok; end
      end
    end
  end
end
