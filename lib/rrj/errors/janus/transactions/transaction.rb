# frozen_string_literal: true

module RubyRabbitmqJanus
  module Errors
    module Janus
      class BaseTransaction < BaseJanus
        def initialize(message, level = :fatal)
          super "[Transaction] #{message}", level
        end
      end

      module Transaction
        class Initialize < RubyRabbitmqJanus::Errors::Janus::BaseTransaction
          def initialize
            super 'Error in initializer'
          end
        end
      end
    end
  end
end
