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
        end

        # Return options to message for rabbitmq
        def options
          properties.options_admin
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
