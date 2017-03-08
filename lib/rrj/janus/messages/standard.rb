# frozen_string_literal: true

module RubyRabbitmqJanus
  module Janus
    module Messages
      # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
      #
      # # Create an standard message
      class Standard < Message
        # Return options to message for rabbitmq
        def options
          properties.options
        rescue => error
          raise Errors::JanusMessagePropertie, error
        end

        private

        def prepare_request(options)
          @request = Tools::Replaces::Handle.new(request,
                                                 options).transform_request
          super
        end
      end
    end
  end
end
