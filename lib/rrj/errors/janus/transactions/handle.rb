# frozen_string_literal: true

module RubyRabbitmqJanus
  module Errors
    module Janus
      # Define a super class for error in Janus::Transactions::TransactionHandle
      class BaseTransactionHandle < BaseTransaction
        def initialize(message, level = :fatal)
          super "[Handle] #{message}", level
        end
      end

      module TransactionHandle
        # Error for Janus::Transactions::TransactionHandle#initialize
        class Initialize < Errors::Janus::BaseTransactionHandle
          def initialize
            super 'Error in initializer'
          end
        end

        # Error for Janus::Transactions::TransactionHandle#connect
        class Connect < Errors::Janus::BaseTransactionHandle
          def initialize
            super 'Error for connect to RabbitMQ'
          end
        end

        # Error for Janus::Transactions::TransactionHandle#publish_message
        class PublishMessage < Errors::Janus::BaseTransactionHandle
          def initialize
            super 'Error for publishing message'
          end
        end

        # Error for Janus::Transactions::TransactionHandle#detach
        class Detach < Errors::Janus::BaseTransactionHandle
          def initialize
            super 'Error for sending message to type detach'
          end
        end

        # Error for Janus::Transactions::TransactionHandle#detach_for_deleteing
        class DetachForDeleting < Errors::Janus::BaseTransactionHandle
          def initialize
            super 'Error for sending message detach ' \
                  'and update in database Janus instance'
          end
        end
      end
    end
  end
end
