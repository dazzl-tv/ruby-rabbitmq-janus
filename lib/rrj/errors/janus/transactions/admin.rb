# frozen_string_literal: true

module RubyRabbitmqJanus
  module Errors
    module Janus
      class BaseTransactionAdmin < RubyRabbitmqJanus::Errors::Janus::BaseTransaction
        def initialize(message, level = :fatal)
          super "[Admin] #{message}", level
        end
      end

      module TransactionAdmin
        class Initialize < RubyRabbitmqJanus::Errors::Janus::BaseTransactionAdmin
          def initialize
            super 'Error in initializer'
          end
        end

        class Connect < RubyRabbitmqJanus::Errors::Janus::BaseTransactionAdmin
          def initialize
            super 'Error to connection RabbitMQ'
          end
        end

        class PublishMessage < RubyRabbitmqJanus::Errors::Janus::BaseTransactionAdmin
          def initialize
            super 'Error for publishing message in RabbitMQ'
          end
        end
      end
    end
  end
end
