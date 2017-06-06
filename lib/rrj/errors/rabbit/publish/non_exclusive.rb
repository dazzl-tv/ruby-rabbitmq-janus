# frozen_string_literal: true

module RubyRabbitmqJanus
  module Errors
    module Rabbit
      # Define a super class for all errors in
      # Rabbit::Publisher::PublishNonExclusive
      class BasePublishNonExclusive < BaseErrorPublisher
        def initialize(message, level = :fatal)
          super "[Non Exclusive] #{message}", level
        end
      end

      module PublishNonExclusive
        # Error for Rabbit::Publisher::PublishNonExclusive#initialize
        class Initialize < Errors::Rabbit::BasePublishNonExclusive
          def initialize
            super 'Error in initializer'
          end
        end

        # Error for Rabbit::Publisher::PublishNonExclusive#publish
        class Publish < Errors::Rabbit::BasePublishNonExclusive
          def initialize
            super 'Error for publish message'
          end
        end
      end
    end
  end
end
