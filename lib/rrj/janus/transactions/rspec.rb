# frozen_string_literal: true

module RubyRabbitmqJanus
  module Janus
    module Transactions
      # Transaction for RSpec initializer
      # @!attribute [r] response
      #     Given a Janus response
      class RSpec
        attr_reader :response

        # Initialize fake object
        def initialize
          @response = nil
        end

        # Fake method
        def connect; end

        # Fake method
        def detach; end

        # Fake method
        def detach_for_deleting; end

        # Publish fake message
        def publish_message(type, _options)
          @response = Janus::Responses::RSpec.new(type)
        end
      end
    end
  end
end
