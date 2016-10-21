# frozen_string_literal: true
# :reek:InstanceVariableAssumption

module RubyRabbitmqJanus
  module Janus
    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
    # Create an message for janus
    class MessageAdmin < Message
      # Return options to message for rabbitmq
      def options
        Tools::Log.instance.debug 'Options used for admin message'
        @properties.options_admin
      rescue => error
        raise Errors::JanusMessagePropertie, error
      end
    end
  end
end
