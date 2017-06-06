# frozen_string_literal: true

module RubyRabbitmqJanus
  module Errors
    module Janus
      # Define a super class for error in Janus::Transactions::TransactionAdmin
      class BaseTransactionAdmin < BaseTransaction
        def initialize(message, level = :fatal)
          super "[Admin] #{message}", level
        end
      end

      module TransactionAdmin
        # Error for Janus::Transactions::TransactionAdmin#initialize
        class Initialize < BaseTransactionAdmin
          def initialize
            super 'Error in initializer'
          end
        end

        # Error for Janus::Transactions::TransactionAdmin#connect
        class Connect < BaseTransactionAdmin
          def initialize
            super 'Error to connection RabbitMQ'
          end
        end

        # Error for Janus::Transactions::TransactionAdmin#publish_message
        class PublishMessage < BaseTransactionAdmin
          def initialize
            super 'Error for publishing message in RabbitMQ'
          end
        end
      end
    end
  end
end
