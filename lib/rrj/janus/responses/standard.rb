# frozen_string_literal: true

module RubyRabbitmqJanus
  module Janus
    # Modules for manipulate responses sending by Janus
    module Responses
      # Response for events message
      class Standard < Response
        # Return a response simple for client
        def for_plugin
          case request['janus']
          when 'success' then request['plugindata']['data']
          when 'ack' then {}
          end
        rescue => error
          Tools::Log.instance.debug "Request error : #{request}"
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
          request['data']['id'].to_i
        rescue => error
          raise Errors::JanusResponseDataId, error
        end
      end
    end
  end
end
