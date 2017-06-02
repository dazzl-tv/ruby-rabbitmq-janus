# frozen_string_literal: true

module RubyRabbitmqJanus
  module Errors
    module Janus
      class BaseTransactionSessions < RubyRabbitmqJanus::Errors::Janus::BaseTransaction
        def initialize(message, level = :fatal)
          super "[Sessions] #{message}", level
        end
      end

      module TransactionSessions
        class Initialize < RubyRabbitmqJanus::Errors::Janus::BaseTransactionSessions
          def initialize
            super 'Error in initializer'
          end
        end

        class Connect < RubyRabbitmqJanus::Errors::Janus::BaseTransactionSessions
          def initialize
            super 'Error for connect to RabbitMQ'
          end
        end

        class PublishMessage < RubyRabbitmqJanus::Errors::Janus::BaseTransactionSessions
          def initialize
            super 'Error for publishing message'
          end
        end
      end
    end
  end
end
