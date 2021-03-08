# frozen_string_literal: true

module RubyRabbitmqJanus
  module Errors
    module Rabbit
      # Define a super class for all error in Option class
      class BaseConnect < BaseRabbit
        def initialize(message, level = :fatal)
          super("[Connect] #{message}", level)
        end
      end

      module Connect
        # Error for Rabbit::Connect#initialize
        class Initialize < RubyRabbitmqJanus::Errors::Rabbit::BaseConnect
          def initialize(error)
            super "Error in initializer #{error}"
          end
        end

        # Error when transaction hs no block
        class MissingAction < RubyRabbitmqJanus::Errors::Rabbit::BaseConnect
          def initialize
            super 'Transaction failed, missing block'
          end
        end

        # Error When transaction timeout
        class TransactionTimeout < RubyRabbitmqJanus::Errors::Rabbit::BaseConnect
          def initialize
            super 'Transaction timeout.'
          end
        end
      end
    end
  end
end
