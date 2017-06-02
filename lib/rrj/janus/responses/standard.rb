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
        rescue
          raise Errors::Janus::ResponseStandard::Session
        end

        alias sender session

        # Return session used in request
        def session_id
          request['session_id']
        rescue
          raise Errors::Janus::ResponseStandard::Session_id
        end

        # Read response for plugin request
        def plugin
          request['plugindata']
        rescue
          raise Errors::Janus::ResponseStandard::Plugin
        end

        # Read data response for plugin request
        def plugin_data
          plugin['data']
        rescue
          raise Errors::Janus::ResponseStandard::PluginData
        end

        # Read data response for normal request
        def data
          request['data']
        rescue
          raise Errors::Janus::ResponseStandard::Data
        end

        # Read SDP response
        def sdp
          request['jsep']['sdp']
        rescue
          raise Errors::Janus::ResponseStandard::SDP
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
