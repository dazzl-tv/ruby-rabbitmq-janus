# frozen_string_literal: true

module RubyRabbitmqJanus
  module Janus
    module Messages
      # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
      # Create an message for janus
      class Admin < Message
        # Return options to message for rabbitmq
        def options
          Tools::Log.instance.debug 'Options used for admin message'
          properties.options_admin
        rescue => error
          raise Errors::JanusMessagePropertie, error
        end

        private

        # Transform raw request in request to janus, so replace element
        # <string>, <number> and other with real value
        def prepare_request(options)
          @request = Tools::Replaces::Admin.new(request,
                                                options).transform_request
          super
        end
      end
    end
  end
end
