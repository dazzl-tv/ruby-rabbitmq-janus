# frozen_string_literal: true

module RubyRabbitmqJanus
  module Errors
    module Janus
      # Define a super class for all error in Janus::Message
      class BaseMessage < BaseJanus
        def initialize(message, level)
          super "[Message]#{message}", level
        end
      end

      module Message
        # Error for Janus::Message#initialize
        class Initializer < RubyRabbitmqJanus::Errors::Janus::BaseMessage
          def initialize
            super 'Error in initalizer'
          end
        end

        # Error for Janus::Message#to_json
        class ToJson < RubyRabbitmqJanus::Errors::Janus::BaseMessage
          def initialize
            super 'Error transform to json'
          end
        end

        # Error for Janus::Message#to_nice_json
        class ToNiceJson < RubyRabbitmqJanus::Errors::Janus::BaseMessage
          def initialize
            super 'Error transform to nice json'
          end
        end

        # Error for Janus::Message#to_hash
        class ToHash < RubyRabbitmqJanus::Errors::Janus::BaseMessage
          def initialize
            super 'Error transform to hash'
          end
        end

        # Error for Janus::Message#correlation
        class Correlation < RubyRabbitmqJanus::Errors::Janus::BaseMessage
          def initialize
            super 'Error return correlation information'
          end
        end
      end
    end
  end
end
