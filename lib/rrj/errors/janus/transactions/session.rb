# frozen_string_literal: true

module RubyRabbitmqJanus
  module Errors
    module Janus
      # Define a super class for all errors in
      # Janus::Transactions::TransactionSessions
      class BaseTransactionSessions < BaseTransaction
        def initialize(message, level = :fatal)
          super "[Sessions] #{message}", level
        end
      end

      module TransactionSessions
        # Error for Janus::Transactions::TransactionSessions#initialize
        class Initialize < BaseTransactionSessions
          def initialize
            super 'Error in initializer'
          end
        end

        # Error for Janus::Transactions::TransactionSessions#connect
        class Connect < BaseTransactionSessions
          def initialize
            super 'Error for connect to RabbitMQ'
          end
        end

        # Error for Janus::Transactions::TransactionSessions#publish_message
        class PublishMessage < BaseTransactionSessions
          def initialize
            super 'Error for publishing message'
          end
        end
      end
    end
  end
end
