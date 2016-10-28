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

      private

      # Transform raw request in request to janus, so replace element <string>, <number>
      # and other with real value
      def prepare_request(options)
        @request = Tools::AdminReplace.new(@request, options).transform_request
        Tools::Log.instance.debug "Prepare request admin for janus : #{to_json}"
      end
    end
  end
end
