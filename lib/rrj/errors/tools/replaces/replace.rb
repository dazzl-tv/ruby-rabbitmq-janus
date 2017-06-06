# frozen_string_literal: true

module RubyRabbitmqJanus
  module Errors
    module Tools
      # Super class error for Replace class
      class BaseReplace < BaseTools
        def initialize(message, level = :fatal)
          super "[Replace] #{message}", level
        end
      end

      module Replace
        # Error for initialize in Replace class
        class Initialize < RubyRabbitmqJanus::Errors::Tools::BaseReplace
          def initialize
            super 'Error in initializer'
          end
        end

        # Error for transform_request in Replace class
        class TransformRequest < RubyRabbitmqJanus::Errors::Tools::BaseReplace
          def initialize
            super 'Error for transform base request element'
          end
        end
      end
    end
  end
end
