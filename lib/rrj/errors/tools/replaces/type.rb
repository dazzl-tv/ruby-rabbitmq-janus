# frozen_string_literal: true

module RubyRabbitmqJanus
  module Errors
    module Tools
      # Super class error for Type class
      class BaseType < BaseTools
        def initialize(message, level = :fatal)
          super "[Type] #{message}", level
        end
      end

      module Type
        # Error for initialize method in Type class
        class Initialize < RubyRabbitmqJanus::Errors::Tools::BaseType
          def initialize
            super 'Error in initializer'
          end
        end

        # Error for convert method in Type class
        class Convert < RubyRabbitmqJanus::Errors::Tools::BaseType
          def initialize
            super 'Error for converting data to good type'
          end
        end
      end
    end
  end
end
