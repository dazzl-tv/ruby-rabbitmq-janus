# frozen_string_literal: true

module RubyRabbitmqJanus
  module Janus
    module Transactions
      # Transaction for RSpec initializer
      class RSpec
        attr_reader :response

        def initialize
          @response = nil
        end

        def connect; end

        def detach; end

        def detach_for_deleting; end

        def publish_message(type, _options)
          @response = Janus::Responses::RSpec.new(type)
        end
      end
    end
  end
end
