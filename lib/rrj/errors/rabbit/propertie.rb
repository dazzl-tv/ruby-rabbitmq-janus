# frozen_string_literal: true

module RubyRabbitmqJanus
  module Errors
    module Rabbit
      # Define a super class for all error in Option class
      class BasePropertie < BaseRabbit
        def initialize(message, level = :fatal)
          super("[Propertie] #{message}", level)
        end
      end

      module Propertie
        class Initialize < RubyRabbitmqJanus::Errors::Rabbit::BasePropertie
          def initialize
            super 'Error in initializer'
          end
        end

        class Options < RubyRabbitmqJanus::Errors::Rabbit::BasePropertie
          def initialize
            super 'Error for create hash to propertie message'
          end
        end

        class OptionsAdmin < RubyRabbitmqJanus::Errors::Rabbit::BasePropertie
          def initialize
            super 'Error for create hash to propertie message admin'
          end
        end
      end
    end
  end
end
