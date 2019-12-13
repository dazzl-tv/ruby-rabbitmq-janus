# frozen_string_literal: true

module RubyRabbitmqJanus
  module Errors
    module Janus
      module Responses
        class Base < RubyRabbitmqJanus::Errors::RRJError
          def initialize(klass, message, level = :warning)
            super level, "[Response][#{klass}] Error sessions information reading"
          end
        end
      end
    end
  end
end
