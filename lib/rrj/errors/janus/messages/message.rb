# frozen_string_literal: true

module RubyRabbitmqJanus
  module Errors
    module Janus
      class BaseMessage < BaseJanus
        def initialize(message, level)
          super "[Message]#{message}", level
        end
      end

      module Message
        class Initializer < RubyRabbitmqJanus::Errors::Janus::BaseMessage
          def initialize
            super 'Error in initalizer'
          end
        end

        class ToJson < RubyRabbitmqJanus::Errors::Janus::BaseMessage
          def initialize
            super 'Error transform to json'
          end
        end

        class ToNiceJson < RubyRabbitmqJanus::Errors::Janus::BaseMessage
          def initialize
            super 'Error transform to nice json'
          end
        end

        class ToHash < RubyRabbitmqJanus::Errors::Janus::BaseMessage
          def initialize
            super 'Error transform to hash'
          end
        end

        class Correlation < RubyRabbitmqJanus::Errors::Janus::BaseMessage
          def initialize
            super 'Error return correlation information'
          end
        end
      end
    end
  end
end
