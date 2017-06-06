# frozen_string_literal: true

module RubyRabbitmqJanus
  module Errors
    module Rabbit
      # Define a super class for all errors in Rabbit::Publisher::BasePublisher
      class BaseErrorPublisher < BaseRabbit
        def initialize(message, level = :fatal)
          super "[Publisher] #{message}", level
        end
      end

      module BasePublisher
        # Error for Rabbit::Publisher::BasePublisher#initialize
        class Initialize < RubyRabbitmqJanus::Errors::Rabbit::BaseErrorPublisher
          def initialize
            super 'Error in initializer'
          end
        end
      end
    end
  end
end
