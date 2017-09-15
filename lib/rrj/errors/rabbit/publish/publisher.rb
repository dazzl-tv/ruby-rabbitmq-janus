# frozen_string_literal: true

# :reek:IrresponsibleModule
#
module RubyRabbitmqJanus
  module Errors
    module Rabbit
      # Define a super class for all errors in Rabbit::Publisher::Publish
      class BasePublish < BaseErrorPublisher
        def initialize(message, level = :fatal)
          super "[Publisher] #{message}", level
        end
      end

      module Publish
        # Error for Rabbit::Publisher::Publish#initialize
        class Initialize < RubyRabbitmqJanus::Errors::Rabbit::BasePublish
          def initialize
            super 'Error in initializer'
          end
        end

        # Error for Rabbit::Publisher::Publish#publish
        class Publish < RubyRabbitmqJanus::Errors::Rabbit::BasePublish
          def initialize
            super 'Error for publish message'
          end
        end

        class Testcorrelation < RubyRabbitmqJanus::Errors::Rabbit::BasePublish
          def initialize(message, propertie)
            super "Response correlation ID mismatch (#{message} != #{propertie})", :fatal
          end
        end
      end
    end
  end
end
