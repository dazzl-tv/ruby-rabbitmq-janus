# frozen_string_literal: true

module RubyRabbitmqJanus
  module Errors
    module Janus
      module Responses
        class Base < RubyRabbitmqJanus::Errors::RRJError
          def initialize(klass, message, level = :warn)
            super "[Response][#{klass}] #{message}", level
          end
        end
      end
    end
  end
end
