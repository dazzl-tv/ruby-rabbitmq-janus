# frozen_string_literal: true

module RubyRabbitmqJanus
  module Errors
    module Rabbit
      class BaseErrorPublisher < BaseRabbit
        def initialize(message, level = :fatal)
          super "[Publisher] #{message}", level
        end
      end

      module BasePublisher
        class Initialize < RubyRabbitmqJanus::Errors::Rabbit::BaseErrorPublisher
          def initialize
            super 'Error in initializer'
          end
        end
      end
    end
  end
end
