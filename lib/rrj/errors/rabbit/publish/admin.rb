# frozen_string_literal: true

module RubyRabbitmqJanus
  module Errors
    module Rabbit
      class BasePublisherAdmin < BaseErrorPublisher
        def initialize(message, level = :fatal)
          super "[Admin] #{message}", level
        end
      end

      module PublisherAdmin
        class Initialize < RubyRabbitmqJanus::Errors::Rabbit::BasePublisherAdmin
          def initialize
            super 'Error in initializer'
          end
        end

        class Publish < RubyRabbitmqJanus::Errors::Rabbit::BasePublisherAdmin
          def initialize
            super 'Error for publish message'
          end
        end
      end
    end
  end
end
