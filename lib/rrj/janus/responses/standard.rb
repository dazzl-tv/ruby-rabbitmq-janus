# frozen_string_literal: true

module RubyRabbitmqJanus
  module Janus
    # Modules for manipulate responses sending by Janus
    module Responses
      # Response for events message
      class Standard < Response
        # Return a integer to session
        def session
          data_id
        end

        alias sender session

        # Return session used in request
        def session_id
          raise RubyRabbitmqJanusErrors::Janus::Responses::Standard::SessionId \
            unless key?('session_id')

          request['session_id']
        end

        # Read response for plugin request
        def plugin
          raise RubyRabbitmqJanus::Errors::Janus::Responses::Standard::Plugin \
            unless key?('plugindata')

          request['plugindata']
        end

        # Read data response for plugin request
        def plugin_data
          raise RubyRabbitmqJanus::Errors::Janus::Responses::Standard::PluginData \
            unless request['plugindata'].key?('data')

          plugin['data']
        end

        # Read data response for normal request
        def data
          raise RubyRabbitmqJanus::Errors::Janus::Responses::Standard::Data \
            unless key?('data')

          request['data']
        end

        # Read SDP response
        def sdp
          raise RubyRabbitmqJanus::Errors::Janus::Responses::Standard::SDP \
            unless request['jsep'].key?('sdp')

          request['jsep']['sdp']
        end

        private

        def data_id
          data['id'].to_i
        end
      end
    end
  end
end
