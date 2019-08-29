# frozen_string_literal: true

# :reek:IrresponsibleModule

module RubyRabbitmqJanus
  module Errors
    module Rabbit
      module Publisher
        # Define a super class for all errors in Rabbit::BaseEvent
        class BaseErrorPublisher < BaseRabbit
          def initialize(message, level = :fatal)
            super "[Publisher] #{message}", level
          end
        end

        module Base
          # Error for Rabbit::BaseEvent#initialize
          class Initialize < RubyRabbitmqJanus::Errors::Rabbit::Publisher::BaseErrorPublisher
            def initialize
              super 'Error in initializer'
            end
          end

          class Publish < RubyRabbitmqJanus::Errors::Rabbit::Publisher::BaseErrorPublisher
            def initialize
              super 'Error for publishing message'
            end
          end

          class TestCorrelation < RubyRabbitmqJanus::Errors::Rabbit::Publisher::BaseErrorPublisher
            def initialize(message, propertie)
              super "Correlation doesn't equal (msg: #{message}) != (prp: #{propertie})"
            end
          end
        end
      end
    end
  end
end
