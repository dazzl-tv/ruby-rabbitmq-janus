# frozen_string_literal: true

module RubyRabbitmqJanus
  module Tools
    module Replaces
      # Format message request with good data to HASH format for Session
      # request.
      # Manage session and plugin.
      #
      # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
      class Session < Replace
        private

        def replace_element_classic
          super
          replace_session if request.key?('session_id')
          replace_plugin if request.key?('plugin')
        end

        def replace_session
          request['session_id'] = type.convert('session_id', opts)
        rescue => exception
          Tools::Log.instance.warn "Error session replace : #{exception}"
        end

        def replace_plugin
          request['plugin'] = type.convert('plugin')
        rescue => exception
          Tools::Log.instance.warn "Error plugin replace : #{exception}"
        end
      end
    end
  end
end
