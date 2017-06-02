# frozen_string_literal: true

module RubyRabbitmqJanus
  module Errors
    module Rabbit
      class BasePublish < BaseErrorPublisher
        def initialize(message, level = :fatal)
          super "[Publisher] #{message}", level
        end
      end

      module Publish
        class Initialize < RubyRabbitmqJanus::Errors::Rabbit::BasePublish
          def initialize
            super 'Error in initializer'
          end
        end

        class Publish < RubyRabbitmqJanus::Errors::Rabbit::BasePublish
          def initialize
            super 'Error for publish message'
          end
        end
      end
    end
  end
end
