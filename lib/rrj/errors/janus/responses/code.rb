# frozen_string_literal: true

module RubyRabbitmqJanus
  module Errors
    module Janus
      module Responses
        class Nok < RubyRabbitmqJanus::Errors::RRJError
          def initialize(request)
            super "[#{request.error_code}] Reason : #{request.error_reason}", :error
          end
        end

        Unknown = Nok
        NotAcceptingSession = Nok
        WebRTCState = Nok
        TokenNotFound = Nok
        UnexpectedAnswer = Nok
        SessionConflit = Nok
        InvalidElementType = Nok
        TrickleInvalidStream = Nok
        JSEPInvalidSDP = Nok
        JSEPUnknownType = Nok
        PluginDetach = Nok
        PluginMessage = Nok
        PluginAttach = Nok
        PluginNotFound = Nok
        HandleNotFound = Nok
        SessionNotFound = Nok
        InvalidRequestPath = Nok
        MissingMandatoryElement = Nok
        InvalidJSONObject = Nok
        InvalidJSON = Nok
        UnknownRequest = Nok
        MissingRequest = Nok
        TransportSpecific = Nok
        UnauthorizedPlugin = Nok
        Unauthorized = Nok
      end
    end
  end
end
