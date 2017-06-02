# frozen_string_literal: true

module RubyRabbitmqJanus
  module Errors
    module Janus
      class BaseTransactionHandle < RubyRabbitmqJanus::Errors::Janus::BaseTransaction
        def initialize(message, level = :fatal)
          super "[Handle] #{message}", level
        end
      end

      module TransactionHandle
        class Initialize < RubyRabbitmqJanus::Errors::Janus::BaseTransactionHandle
          def initialize
            super 'Error in initializer'
          end
        end

        class Connect < RubyRabbitmqJanus::Errors::Janus::BaseTransactionHandle
          def initialize
            super 'Error for connect to RabbitMQ'
          end
        end

        class PublishMessage < RubyRabbitmqJanus::Errors::Janus::BaseTransactionHandle
          def initialize
            super 'Error for publishing message'
          end
        end

        class Detach < RubyRabbitmqJanus::Errors::Janus::BaseTransactionHandle
          def initialize
            super 'Error for sending message to type detach'
          end
        end

        class DetachForDeleting < RubyRabbitmqJanus::Errors::Janus::BaseTransactionHandle
          def initialize
            super 'Error for sending message detach and update in database Janus instance'
          end
        end
      end
    end
  end
end
