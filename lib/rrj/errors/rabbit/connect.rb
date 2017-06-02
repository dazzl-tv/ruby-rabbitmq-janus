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
        class Initialize < RubyRabbitmqJanus::Errors::Rabbit::BaseConnect
          def initialize
            super 'Error in initializer'
          end
        end

        class TransactionShort < RubyRabbitmqJanus::Errors::Rabbit::BaseConnect
          def initialize
            super 'Error during transaction with RabbitMQ'
          end
        end

        class TransactionLong < RubyRabbitmqJanus::Errors::Rabbit::BaseConnect
          def initialize
            super 'Error during transaction with RabbitMQ'
          end
        end

        class Start < RubyRabbitmqJanus::Errors::Rabbit::BaseConnect
          def initialize
            super 'Error for starting connection with RabbitMQ'
          end
        end

        class Close < RubyRabbitmqJanus::Errors::Rabbit::BaseConnect
          def initialize
            super 'Error for closing connection with RabbitMQ'
          end
        end

        class Channel < RubyRabbitmqJanus::Errors::Rabbit::BaseConnect
          def initialize
            super 'Error for create channel in RabbitMQ instance'
          end
        end
      end
    end
  end
end
