# frozen_string_literal: true

module RubyRabbitmqJanus
  module Errors
    module Rabbit
      # Define a super class for all errors in
      # Rabbit::Publisher::PublishExclusive
      class BasePublishExclusive < BaseErrorPublisher
        def initialize(message, level = :fatal)
          super "[Exclusive] #{message}", level
        end
      end

      module PublishExclusive
        # Error for Rabbit::Publisher::PublishExclusive#initialize
        class Initialize < Errors::Rabbit::BasePublishExclusive
          def initialize
            super 'Error in initializer'
          end
        end

        # Error for Rabbit::Publisher::PublishExclusive#publish
        class Publish < Errors::Rabbit::BasePublishExclusive
          def initialize
            super 'Error for publish message'
          end
        end
      end
    end
  end
end
