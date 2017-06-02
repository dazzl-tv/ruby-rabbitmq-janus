# frozen_string_literal: true

module RubyRabbitmqJanus
  module Errors
    module Tools
      # Define super class for all errors in Log class
      class BaseRequest < RRJError
        def initialize(message, level = :fatal)
          super("[Request] #{message}", level)
        end
      end

      module Request
        class Initializer < RubyRabbitmqJanus::Errors::BaseRequest
          def initalize
            super 'Error in initializer'
          end
        end
      end
    end
  end
end
