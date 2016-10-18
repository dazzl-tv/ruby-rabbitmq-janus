# frozen_string_literal: true

module RubyRabbitmqJanus
  module Janus
    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
    # Read and decryt a response to janus
    class Response
      # Instanciate a response
      def initialize(response_janus)
        @request = response_janus
        Tools::Log.instance.debug "Response return : #{to_json}"
      end

      # Return request to json format
      def to_json
        analysis
        @request.to_json
      end

      # Return request to json format with nice format
      def to_nice_json
        JSON.pretty_generate to_hash
      end

      # Return request to hash format
      def to_hash
        analysis
        @request
      end

      # Return a response simple for client
      def for_plugin
        @request['plugindata']['data']
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
      end

      # Analysis response and send exception if janus return an error
      # :reek:DuplicateMethodCall
      def analysis
        raise Errors::JanusSimple, @request['error'] if @request['janus'].equal? 'error'
        raise Errors::JanusPlugin, @request['plugindata']['data'] if \
          @request.key?('plugindata') && @request['plugindata']['data'].key?('error_code')
      end
    end
  end
end
