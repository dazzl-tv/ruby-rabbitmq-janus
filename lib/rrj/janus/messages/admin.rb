# frozen_string_literal: true

module RubyRabbitmqJanus
  module Janus
    module Messages
      # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
      #
      # Create an message for janus
      class Admin < Message
        def initialize(template_request, options = {})
          super(template_request, options)
        rescue
          raise Errors::Janus::MessageAdmin::Initializer
        end

        # Return options to message for rabbitmq
        def options
          properties.options_admin(type)
        rescue
          raise Errors::Janus::MessageAdmin::Options
        end

        private

        def prepare_request(options)
          @request = Tools::Replaces::Admin.new(request,
                                                options).transform_request
          super
        end
      end
    end
  end
end
