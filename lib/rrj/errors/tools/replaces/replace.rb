# frozen_string_literal: true

module RubyRabbitmqJanus
  module Errors
    module Tools
      class BaseReplace < BaseTools
        def initialize(message, level = :fatal)
          super "[Replace] #{message}", level
        end
      end

      module Replace
        class Initialize < RubyRabbitmqJanus::Errors::Tools::BaseReplace
          def initialize
            super 'Error in initializer'
          end
        end

        class TransformRequest < RubyRabbitmqJanus::Errors::Tools::BaseReplace
          def initialize
            super 'Error for transform base request element'
          end
        end
      end
    end
  end
end
