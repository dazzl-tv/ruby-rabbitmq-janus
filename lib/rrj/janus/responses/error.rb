# frozen_string_literal: true

# rubocop:disable Metrics/LineLength

module RubyRabbitmqJanus
  module Janus
    module Responses
      # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
      #
      # @since 3.0.0
      #
      # Manage exception to response Janus
      class Errors
        # Unauthorized (can only happen when using apisecret/auth token)
        def _403(request)
          raise RubyRabbitmqJanus::Errors::Janus::Responses::Unauthorized, request
        end

        # Unauthorized access to a plugin (can only
        # happen when using auth token)
        def _405(request)
          raise RubyRabbitmqJanus::Errors::Janus::Responses::UnauthorizedPlugin, request
        end

        # Transport related error
        def _450(request)
          raise RubyRabbitmqJanus::Errors::Janus::Responses::TransportSpecific, request
        end

        # The request is missing in the message
        def _452(request)
          raise RubyRabbitmqJanus::Errors::Janus::Responses::MissingRequest, request
        end

        # The Janus core does not suppurt this request
        def _453(request)
          raise RubyRabbitmqJanus::Errors::Janus::Responses::UnknownRequest, request
        end

        # The payload is not a valid JSON message
        def _454(request)
          raise RubyRabbitmqJanus::Errors::Janus::Responses::InvalidJSON, request
        end

        # The object is not a valid JSON object as expected
        def _455(request)
          raise RubyRabbitmqJanus::Errors::Janus::Responses::InvalidJSONObject, request
        end

        # A mandatory element is missing in the message
        def _456(request)
          raise RubyRabbitmqJanus::Errors::Janus::Responses::MissingMandatoryElement, request
        end

        # The request cannot be handled for this webserver path
        def _457(request)
          raise RubyRabbitmqJanus::Errors::Janus::Responses::InvalidRequestPath, request
        end

        # The session the request refers to doesn't exist
        def _458(request)
          raise RubyRabbitmqJanus::Errors::Janus::Responses::SessionNotFound, request
        end

        # The handle the request refers to doesn't exist
        def _459(request)
          raise RubyRabbitmqJanus::Errors::Janus::Responses::HandleNotFound, request
        end

        # The plugin the request wants to talk to doesn't exist
        def _460(request)
          raise RubyRabbitmqJanus::Errors::Janus::Responses::PluginNotFound, request
        end

        # An error occurring when trying to attach to
        # a plugin and create a handle
        def _461(request)
          raise RubyRabbitmqJanus::Errors::Janus::Responses::PluginAttach, request
        end

        # An error occurring when trying to send a message/request to the plugin
        def _462(request)
          raise RubyRabbitmqJanus::Errors::Janus::Responses::PluginMessage, request
        end

        # brief An error occurring when trying to detach from
        # a plugin and destroy the related handle
        def _463(request)
          raise RubyRabbitmqJanus::Errors::Janus::Responses::PluginDetach, request
        end

        # The Janus core doesn't support this SDP type
        def _464(request)
          raise RubyRabbitmqJanus::Errors::Janus::Responses::JSEPUnknownType, request
        end

        # The Session Description provided by the peer is invalid
        def _465(request)
          raise RubyRabbitmqJanus::Errors::Janus::Responses::JSEPInvalidSDP, request
        end

        # The stream a trickle candidate for does not exist or is invalid
        def _466(request)
          raise RubyRabbitmqJanus::Errors::Janus::Responses::TrickleInvalidStream, request
        end

        # A JSON element is of the wrong type
        # (e.g., an integer instead of a string)
        def _467(request)
          raise RubyRabbitmqJanus::Errors::Janus::Responses::InvalidElementType, request
        end

        # The ID provided to create a new session is already in use
        def _468(request)
          raise RubyRabbitmqJanus::Errors::Janus::Responses::SessionConflit, request
        end

        # We got an ANSWER to an OFFER we never made
        def _469(request)
          raise RubyRabbitmqJanus::Errors::Janus::Responses::UnexpectedAnswer, request
        end

        # The auth token the request refers to doesn't exist
        def _470(request)
          raise RubyRabbitmqJanus::Errors::Janus::Responses::TokenNotFound, request
        end

        # The current request cannot be handled because
        # of not compatible WebRTC state
        def _471(request)
          raise RubyRabbitmqJanus::Errors::Janus::Responses::WebRTCState, request
        end

        # The server is currently configured not to accept new sessions
        def _472(request)
          raise RubyRabbitmqJanus::Errors::Janus::Responses::NotAcceptingSession, request
        end

        # Unknown/undocumented error
        def _490(request)
          raise RubyRabbitmqJanus::Errors::Janus::Responses::Unknown, request
        end

        def respond_to_missing?(name, include_private); end

        # rubocop:disable Style/MethodMissingSuper
        def method_missing(_method, request)
          default_error(request)
        end
        # rubocop:enable Style/MethodMissingSuper

        def default_error(request)
          raise RubyRabbitmqJanus::Errors::Janus::Responses::Nok, request
        end
      end
    end
  end
end
# rubocop:enable Metrics/LineLength
