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

        def session_id
          request['session_id']
        end

        # Return a integer to handle
        def sender
          data_id
        end

        def handle_id
          request['sender']
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

        # Read a hash and return an identifier
        def data_id
          data['id'].to_i
        rescue => error
          raise Errors::JanusResponseDataId, error
        end
      end
    end
  end
end
