# frozen_string_literal: true

module RubyRabbitmqJanus
  module Errors
    module Tools
      # Define super class for all errors in request class
      class BaseRequest < BaseTools
        def initialize(message, level = :fatal)
          super("[Request] #{message}", level)
        end
      end

      module Request
        # Error initialize method for Request class
        class Initializer < RubyRabbitmqJanus::Errors::Tools::BaseRequest
          def initalize
            super 'Error in initializer'
          end
        end
      end
    end
  end
end
