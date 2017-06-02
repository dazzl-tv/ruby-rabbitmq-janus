# frozen_string_literal: true

module RubyRabbitmqJanus
  module Errors
    module Rabbit
      class BasePublishNonExclusive < BaseErrorPublisher
        def initialize(message, level = :fatal)
          super "[Non Exclusive] #{message}", level
        end
      end

      module PublishNonExclusive
        class Initialize < RubyRabbitmqJanus::Errors::Rabbit::BasePublishNonExclusive
          def initialize
            super 'Error in initializer'
          end
        end

        class Publish < RubyRabbitmqJanus::Errors::Rabbit::BasePublishNonExclusive
          def initialize
            super 'Error for publish message'
          end
        end
      end
    end
  end
end
