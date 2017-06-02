# frozen_string_literal: true

module RubyRabbitmqJanus
  module Errors
    module Janus
      class BaseResponse < RubyRabbitmqJanus::Errors::BaseJanus
        def initialize(message, level = :fatal)
          super "[Response] #{message}", level
        end
      end

      module Response
        class Initializer < RubyRabbitmqJanus::Errors::Janus::BaseResponse
          def initialize
            super 'Error in intializer'
          end
        end

        class ToJson < RubyRabbitmqJanus::Errors::Janus::BaseResponse
          def initialize
            super 'Error transform response in json'
          end
        end

        class ToNiceJson < RubyRabbitmqJanus::Errors::Janus::BaseResponse
          def initialize
            super 'Error transform response in nice json'
          end
        end

        class ToHash < RubyRabbitmqJanus::Errors::Janus::BaseResponse
          def initialize
            super 'Error transform response in hash'
          end
        end
      end
    end
  end
end
