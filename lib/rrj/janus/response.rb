# frozen_string_literal: true

module RubyRabbitmqJanus
  module Janus
    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
    # Read and decryt a response to janus
    class Response
      # Instanciate a response
      def initialize(response_janus)
        @request = response_janus
      rescue => error
        raise Errors::JanusResponseInit, error
      else
        Tools::Log.instance.debug "Response return : #{to_json}"
      end

      # Return request to json format
      def to_json
        analysis
        @request.to_json
      rescue => error
        raise Errors::JanusResponseJson, error
      end

      # Return request to json format with nice format
      def to_nice_json
        JSON.pretty_generate to_hash
      rescue => error
        raise Errors::JanusResponsePrettyJson, error
      end

      # Return request to hash format
      def to_hash
        analysis
        @request
      rescue => error
        raise Errors::JanusResponseHash, error
      end

      # Return a response simple for client
      def for_plugin
        case @request['janus']
        when 'success' then @request['plugindata']['data']
        when 'ack' then {}
        end
      rescue => error
        raise Errors::JanusResponsePluginData, error
      end

      # Return a integer to session
      def session
        data_id
      end

      # Return a integer to handle
      def sender
        data_id
      end

      private

      # Read a hash and return an identifier
      def data_id
        analysis
        @request['data']['id'].to_i
      rescue => error
        raise Errors::JanusResponseDataId, error
      end

      # Analysis response and send exception if janus return an error
      # :reek:DuplicateMethodCall
      def analysis
        raise Errors::JanusResponseSimple, @request['error'] if error_simple?
        raise Errors::JanusResponsePlugin, @request['plugindata']['data'] if error_plugin?
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
