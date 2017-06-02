# frozen_string_literal: true

module RubyRabbitmqJanus
  module Errors
    module Rabbit
      class BasePublishExclusive < BaseErrorPublisher
        def initialize(message, level = :fatal)
          super "[Exclusive] #{message}", level
        end
      end

      module PublishExclusive
        class Initialize < RubyRabbitmqJanus::Errors::Rabbit::BasePublishExclusive
          def initialize
            super 'Error in initializer'
          end
        end

        class Publish < RubyRabbitmqJanus::Errors::Rabbit::BasePublishExclusive
          def initialize
            super 'Error for publish message'
          end
        end
      end
    end
  end
end
