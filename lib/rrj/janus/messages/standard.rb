# frozen_string_literal: true

module RubyRabbitmqJanus
  module Janus
    module Messages
      # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
      #
      # # Create an standard message
      class Standard < Message
        def initialize(template_request, options = {})
          super(template_request, options)
        rescue
          raise Errors::Janus::MessageStandard::Initializer
        end

        # Return options to message for rabbitmq
        def options
          properties.options
        rescue
          raise Errors::Janus::MessageStandard::Options
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
