# frozen_string_literal: true

module RubyRabbitmqJanus
  module Tools
    module Replaces
      # Format message request with good data to HASH format
      # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
      class Session < Replace
        private

        # Replace classic elements
        def replace_element_classic
          super
          replace_session if request.key?('session_id')
          replace_plugin if request.key?('plugin')
        end

        # Read option session and replace in request
        def replace_session
          request['session_id'] = type.convert('session_id', opts)
        rescue => message
          Tools::Log.instance.warn "Error session replace : #{message}"
        end

        # Replace plugin string
        def replace_plugin
          request['plugin'] = type.convert('plugin')
        rescue => message
          Tools::Log.instance.warn "Error plugin replace : #{message}"
        end
      end
    end
  end
end
