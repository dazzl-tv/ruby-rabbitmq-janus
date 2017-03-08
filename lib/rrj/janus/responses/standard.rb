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
          request['session_id']
        end

        # Read response for plugin request
        def plugin
          request['plugindata']
        end

        # Read data response for plugin request
        def plugin_data
          plugin['data']
        end

        # Read data response for normal request
        def data
          request['data']
        end

        # Read SDP response
        def sdp
          request['jsep']['sdp']
        end

        private

        def data_id
          data['id'].to_i
        rescue => error
          raise Errors::JanusResponseDataId, error
        end
      end
    end
  end
end
