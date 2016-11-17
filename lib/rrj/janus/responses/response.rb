# frozen_string_literal: true

module RubyRabbitmqJanus
  module Janus
    # Modules for manipulate responses sending by Janus
    module Responses
      # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
      # Read and decryt a response to janus
      # :reek:TooManyMethods
      class Response
        # Instanciate a response
        def initialize(response_janus)
          @request = response_janus
        rescue => error
          Tools::Log.instance.debug "Request error [initialize] : #{@request}"
          raise Errors::JanusResponseInit, error
        else
          Tools::Log.instance.debug "Response return : #{to_json}"
        end

        # Return request to json format
        def to_json
          analysis
          @request.to_json
        rescue => error
          Tools::Log.instance.debug "Request error [to_json] : #{@request}"
          raise Errors::JanusResponseJson, [error, @request]
        end

        # Return request to json format with nice format
        def to_nice_json
          JSON.pretty_generate to_hash
        rescue => error
          Tools::Log.instance.debug "Request error [to_nice_json] : #{@request}"
          raise Errors::JanusResponsePrettyJson, error
        end

        # Return request to hash format
        def to_hash
          analysis
          @request
        rescue => error
          Tools::Log.instance.debug "Request error [to_hash] : #{@request}"
          raise Errors::JanusResponseHash, [error, @request]
        end

        private

        attr_accessor :request

        # Analysis response and send exception if janus return an error
        # :reek:DuplicateMethodCall
        def analysis
          raise Errors::JanusResponseSimple, @request if error_simple?
          raise Errors::JanusResponsePlugin, @request['plugindata']['data'] \
            if error_plugin?
        end

        # Test if message response contains an simple error
        def error_simple?
          @request['janus'].equal? 'error'
        end

        # Test if message response contains an error in plugin
        def error_plugin?
          @request.key?('plugindata') && @request['plugindata']['data'].key?('error_code')
        end
      end
    end
  end
end

require 'rrj/janus/responses/standard'
require 'rrj/janus/responses/event'
