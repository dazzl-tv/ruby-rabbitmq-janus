# frozen_string_literal: true

module RubyRabbitmqJanus
  module Errors
    module Tools
      class BaseType < BaseTools
        def initialize(message, level = :fatal)
          super "[Type] #{message}", level
        end
      end

      module Type
        class Initialize < RubyRabbitmqJanus::Errors::Tools::BaseType
          def initialize
            super 'Error in initializer'
          end
        end

        class Convert < RubyRabbitmqJanus::Errors::Tools::BaseType
          def initialize
            super 'Error for converting data to good type'
          end
        end
      end
    end
  end
end
