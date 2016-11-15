# frozen_string_literal: true

module RubyRabbitmqJanus
  module Janus
    # Modules for manipulate responses sending by Janus
    module Responses
      # Response for events message
      class Event < Standard
        # Return event to message
        def event
          request['janus']
        end

        # Return body data
        def data
          request['plugindata']['data'] if plugin_response?
        end

        # Return jsep data
        def jsep
          request['jsep'] if contains_jsep?
        end

        private

        # Test if response contains jsep data
        def contains_jsep?
          request.key?('jsep')
        end

        # Test if response is returning by plugin
        def plugin_response?
          request.key?('plugindata') && request['plugindata'].key?('data')
        end
      end
    end
  end
end
