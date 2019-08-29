# frozen_string_literal: true

module RubyRabbitmqJanus
  module Errors
    module Rabbit
      module Publisher
        # Define a super class for all errors in Rabbit::Publisher::PublisherAdmin
        class BasePublisherAdmin < BaseErrorPublisher
          def initialize(message, level = :fatal)
            super "[Admin] #{message}", level
          end
        end

        module Admin
          # Error for Rabbit::Publisher::PublisherAdmin#initialize
          class Initialize < RubyRabbitmqJanus::Errors::Rabbit::Publisher::BasePublisherAdmin
            def initialize
              super 'Error in initializer'
            end
          end

          # Error for Rabbit::Publisher::PublisherAdmin#publish
          class Publish < RubyRabbitmqJanus::Errors::Rabbit::Publisher::BasePublisherAdmin
            def initialize
              super 'Error for publish message'
            end
          end
        end
      end
    end
  end
end
