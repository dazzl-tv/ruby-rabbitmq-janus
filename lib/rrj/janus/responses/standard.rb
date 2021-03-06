# frozen_string_literal: true

# rubocop:disable Layout/LineLength

module RubyRabbitmqJanus
  module Janus
    # Modules for manipulate responses sending by Janus
    module Responses
      # Response for events message
      class Standard < Response
        # Return a integer to session
        def session
          raise_data

          raise RubyRabbitmqJanus::Errors::Janus::Responses::Standard::Session \
            unless request['data'].key?('id')

          data_id
        end

        # Read value created by janus for session/handle message
        def sender
          raise_data

          raise RubyRabbitmqJanus::Errors::Janus::Responses::Standard::Sender \
            unless request['data'].key?('id')

          data_id
        end

        # Return session used in request
        def session_id
          raise RubyRabbitmqJanus::Errors::Janus::Responses::Standard::SessionId \
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
          raise RubyRabbitmqJanus::Errors::Janus::Responses::Standard::Plugin \
            unless key?('plugindata')

          raise RubyRabbitmqJanus::Errors::Janus::Responses::Standard::PluginData \
            unless request['plugindata'].key?('data')

          plugin['data']
        end

        # Read data response for normal request
        def data
          raise_data

          request['data']
        end

        # Read SDP response
        def sdp
          raise RubyRabbitmqJanus::Errors::Janus::Responses::Standard::JSEP \
            unless key?('jsep')

          raise RubyRabbitmqJanus::Errors::Janus::Responses::Standard::SDP \
            unless jsep.key?('sdp')

          jsep['sdp']
        end

        private

        def raise_data
          raise RubyRabbitmqJanus::Errors::Janus::Responses::Standard::Data \
            unless key?('data')
        end

        def jsep
          request['jsep']
        end

        def data_id
          data['id'].to_i
        end
      end
    end
  end
end
# rubocop:enable Layout/LineLength
