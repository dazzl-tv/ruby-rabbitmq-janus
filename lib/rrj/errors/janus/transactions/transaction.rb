# frozen_string_literal: true

module RubyRabbitmqJanus
  module Errors
    module Janus
      # Define a super class for all errors in Janus::Transactions::Transaction
      class BaseTransaction < BaseJanus
        def initialize(message, level = :fatal)
          super "[Transaction]#{message}", level
        end
      end

      module Transaction
        # Error for Janus::Transactions::Transaction#initialize
        class Initialize < RubyRabbitmqJanus::Errors::Janus::BaseTransaction
          def initialize
            super 'Error in initializer'
          end
        end
      end
    end
  end
end
