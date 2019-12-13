# frozen_string_literal: true

module RubyRabbitmqJanus
  module Errors
    module Janus
      module Response
        class Nok < RubyRabbitmqJanus::Errors::BaseJanus
          def initialize(code, message)
            super "[#{code}] Reason : #{message}", :error
          end
        end

        class Unknown < Nok; end
        class NotAcceptingSession < Nok; end
        class WebRTCState < Nok; end
        class TokenNotFound < Nok; end
        class UnexpectedAnswer < Nok; end
        class SessionConflit < Nok; end
        class InvalidElementType < Nok; end
        class TrickleInvalidStream < Nok; end
        class JSEPInvalidSDP < Nok; end
        class JSEPUnknownType < Nok; end
        class PluginDetach < Nok; end
        class PluginMessage < Nok; end
        class PluginAttach < Nok; end
        class PluginNotFound < Nok; end
        class HandleNotFound < Nok; end
        class SessionNotFound < Nok; end
        class InvalidRequestPath < Nok; end
        class MissingMandatoryElement < Nok; end
        class InvalidJSONObject < Nok; end
        class InvalidJSON < Nok; end
        class UnknownRequest < Nok; end
        class MissingRequest < Nok; end
        class TransportSpecific < Nok; end
        class UnauthorizedPlugin < Nok; end
        class Unauthorized < Nok; end
      end
    end
  end
end
