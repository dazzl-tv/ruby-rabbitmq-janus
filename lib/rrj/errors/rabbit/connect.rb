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

        # Error for Rabbit::Connect#transaction_short
        class TransactionShort < RubyRabbitmqJanus::Errors::Rabbit::BaseConnect
          def initialize(error)
            super "Error during transaction with RabbitMQ #{error}"
          end
        end

        # Error for Rabbit::Connect#transaction_long
        class TransactionLong < RubyRabbitmqJanus::Errors::Rabbit::BaseConnect
          def initialize(error)
            super "Error during transaction with RabbitMQ #{error}"
          end
        end

        # Error for Rabbit::Connect#start
        class Start < RubyRabbitmqJanus::Errors::Rabbit::BaseConnect
          def initialize(error)
            super "Error for starting connection with RabbitMQ #{error}"
          end
        end

        # Error for Rabbit::Connect#close
        class Close < RubyRabbitmqJanus::Errors::Rabbit::BaseConnect
          def initialize(error)
            super "Error for closing connection with RabbitMQ #{error}"
          end
        end

        # Error for Rabbit::Connect#channel
        class Channel < RubyRabbitmqJanus::Errors::Rabbit::BaseConnect
          def initialize(error)
            super "Error for create channel in RabbitMQ instance #{error}"
          end
        end
      end
    end
  end
end
