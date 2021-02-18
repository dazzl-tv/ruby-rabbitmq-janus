# frozen_string_literal: true

module RubyRabbitmqJanus
  module Janus
    # Modules for manipulate responses sending by Janus
    module Responses
      # Response for events message
      class Event < Standard
        # Return event to message
        #
        # @example Januse response
        #   request.event #=> 'success'
        #
        # @return [String] result to request
        def event
          raise RubyRabbitmqJanus::Errors::Janus::Responses::Event::Event \
            unless key?('janus')

          request['janus']
        end

        # Read plugindata data
        #
        # @example Plugindata data
        #   request.data #=> { 'data': { 'audio': false } }
        #
        # @return [Hash] body data
        def data
          raise RubyRabbitmqJanus::Errors::Janus::Responses::Event::Data \
            unless plugin_response?

          request['plugindata']['data']
        end

        # Read jsep data
        #
        # @example Data to jsep
        #   request.jsep #=> { 'jsep': { 'type': '...', 'sdp': '...' } }
        #
        # @return [Hash] jsep data
        def jsep
          raise RubyRabbitmqJanus::Errors::Janus::Responses::Event::Jsep \
            unless key?('jsep')

          request['jsep']
        end

        # session_id and handle_id
        #
        # @example Data to any request
        #   request.keys #=> [123456789, 987654321]
        #
        # @return [Array] Contains session_id and handle_id
        def keys
          raise RubyRabbitmqJanus::Errors::Janus::Responses::Event::Keys \
            unless key?('session_id') && key?('sender')

          [request['session_id'], request['sender']]
        end

        private

        def plugin_response?
          request.key?('plugindata') && request['plugindata'].key?('data')
        end
      end
    end
  end
end
