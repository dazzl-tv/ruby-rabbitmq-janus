# frozen_string_literal: true

module RubyRabbitmqJanus
  module Errors
    module Janus
      # Define a super class for Janus::Responses::Response
      class BaseResponse < RubyRabbitmqJanus::Errors::BaseJanus
        def initialize(message, level = :fatal)
          super "[Response] #{message}", level
        end
      end

      module Response
        # Error for Janus::Responses::Response#initialize
        class Initializer < RubyRabbitmqJanus::Errors::Janus::BaseResponse
          def initialize
            super 'Error in intializer'
          end
        end

        # Error for Janus::Responses::Response#to_json
        class ToJson < RubyRabbitmqJanus::Errors::Janus::BaseResponse
          def initialize
            super 'Error transform response in json'
          end
        end

        # Error for Janus::Responses::Response#to_nice_json
        class ToNiceJson < RubyRabbitmqJanus::Errors::Janus::BaseResponse
          def initialize
            super 'Error transform response in nice json'
          end
        end

        # Error for Janus::Responses::Response#to_hash
        class ToHash < RubyRabbitmqJanus::Errors::Janus::BaseResponse
          def initialize
            super 'Error transform response in hash'
          end
        end
      end
    end
  end
end
