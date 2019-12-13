# frozen_string_literal: true

# rubocop:disable Metrics/ClassLength, Metrics/LineLength

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
          raise RubyRabbitmqJanus::Errors::Janus::Response::Unauthorized,
                request.error_code,
                request.error_reason
        end

        # Unauthorized access to a plugin (can only
        # happen when using auth token)
        def _405(request)
          raise RubyRabbitmqJanus::Errors::Janus::Response::UnauthorizedPlugin,
                request.error_code,
                request.error_reason
        end

        # Transport related error
        def _450(request)
          raise RubyRabbitmqJanus::Errors::Janus::Response::TransportSpecific,
                request.error_code,
                request.error_reason
        end

        # The request is missing in the message
        def _452(request)
          raise RubyRabbitmqJanus::Errors::Janus::Response::MissingRequest,
                request.error_code,
                request.error_reason
        end

        # The Janus core does not suppurt this request
        def _453(request)
          raise RubyRabbitmqJanus::Errors::Janus::Response::UnknownRequest,
                request.error_code,
                request.error_reason
        end

        # The payload is not a valid JSON message
        def _454(request)
          raise RubyRabbitmqJanus::Errors::Janus::Response::InvalidJSON,
                request.error_code,
                request.error_reason
        end

        # The object is not a valid JSON object as expected
        def _455(request)
          raise RubyRabbitmqJanus::Errors::Janus::Response::InvalidJSONObject,
                request.error_code,
                request.error_reason
        end

        # A mandatory element is missing in the message
        def _456(request)
          raise RubyRabbitmqJanus::Errors::Janus::Response::MissingMandatoryElement,
                request.error_code,
                request.error_reason
        end

        # The request cannot be handled for this webserver path
        def _457(request)
          raise RubyRabbitmqJanus::Errors::Janus::Response::InvalidRequestPath,
                request.error_code,
                request.error_reason
        end

        # The session the request refers to doesn't exist
        def _458(request)
          raise RubyRabbitmqJanus::Errors::Janus::Response::SessionNotFound,
                request.error_code,
                request.error_reason
        end

        # The handle the request refers to doesn't exist
        def _459(request)
          raise RubyRabbitmqJanus::Errors::Janus::Response::HandleNotFound,
                request.error_code,
                request.error_reason
        end

        # The plugin the request wants to talk to doesn't exist
        def _460(request)
          raise RubyRabbitmqJanus::Errors::Janus::Response::PluginNotFound,
                request.error_code,
                request.error_reason
        end

        # An error occurring when trying to attach to
        # a plugin and create a handle
        def _461(request)
          raise RubyRabbitmqJanus::Errors::Janus::Response::PluginAttach,
                request.error_code,
                request.error_reason
        end

        # An error occurring when trying to send a message/request to the plugin
        def _462(request)
          raise RubyRabbitmqJanus::Errors::Janus::Response::PluginMessage,
                request.error_code,
                request.error_reason
        end

        # brief An error occurring when trying to detach from
        # a plugin and destroy the related handle
        def _463(request)
          raise RubyRabbitmqJanus::Errors::Janus::Response::PluginDetach,
                request.error_code,
                request.error_reason
        end

        # The Janus core doesn't support this SDP type
        def _464(request)
          raise RubyRabbitmqJanus::Errors::Janus::Response::JSEPUnknownType,
                request.error_code,
                request.error_reason
        end

        # The Session Description provided by the peer is invalid
        def _465(request)
          raise RubyRabbitmqJanus::Errors::Janus::Response::JSEPInvalidSDP,
                request.error_code,
                request.error_reason
        end

        # The stream a trickle candidate for does not exist or is invalid
        def _466(request)
          raise RubyRabbitmqJanus::Errors::Janus::Response::TrickleInvalidStream,
                request.error_code,
                request.error_reason
        end

        # A JSON element is of the wrong type
        # (e.g., an integer instead of a string)
        def _476(request)
          raise RubyRabbitmqJanus::Errors::Janus::Response::InvalidElementType,
                request.error_code,
                request.error_reason
        end

        # The ID provided to create a new session is already in use
        def _468(request)
          raise RubyRabbitmqJanus::Errors::Janus::Response::SessionConflit,
                request.error_code,
                request.error_reason
        end

        # We got an ANSWER to an OFFER we never made
        def _469(request)
          raise RubyRabbitmqJanus::Errors::Janus::Response::UnexpectedAnswer,
                request.error_code,
                request.error_reason
        end

        # The auth token the request refers to doesn't exist
        def _470(request)
          raise RubyRabbitmqJanus::Errors::Janus::Response::TokenNotFound,
                request.error_code,
                request.error_reason
        end

        # The current request cannot be handled because
        # of not compatible WebRTC state
        def _471(request)
          raise RubyRabbitmqJanus::Errors::Janus::Response::WebRTCState,
                request.error_code,
                request.error_reason
        end

        # The server is currently configured not to accept new sessions
        def _472(request)
          raise RubyRabbitmqJanus::Errors::Janus::Response::NotAcceptingSession,
                request.error_code,
                request.error_reason
        end

        # Unknown/undocumented error
        def _490(request)
          raise RubyRabbitmqJanus::Errors::Janus::Response::Unknown,
                request.error_code,
                request.error_reason
        end

        def respond_to_missing?(name, include_private); end

        # rubocop:disable Style/MethodMissingSuper
        def method_missing(_method, request)
          default_error(request.error_code, request.error_reason)
        end
        # rubocop:enable Style/MethodMissingSuper

        def default_error(code, reason)
          raise RubyRabbitmqJanus::Errors::Janus::Response::Nok,
                code,
                reason
        end
      end
    end
  end
end
# rubocop:enable Metrics/ClassLength, Metrics/LineLength
