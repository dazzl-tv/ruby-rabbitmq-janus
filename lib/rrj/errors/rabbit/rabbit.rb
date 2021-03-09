# frozen_string_literal: true

module RubyRabbitmqJanus
  module Errors
    # Define a super class for all error in module Rabbit
    class BaseRabbit < RRJError
      def initialize(message, level = :fatal)
        super "[Rabbit]#{message}", level
      end
    end

    module Connect
      # Error when transaction hs no block
      class MissingAction < RubyRabbitmqJanus::Errors::BaseRabbit
        def initialize
          super 'Transaction failed, missing block'
        end
      end

      # Error When transaction timeout
      class TransactionTimeout < RubyRabbitmqJanus::Errors::BaseRabbit
        def initialize(error)
          super error
        end
      end
    end

    module Listener
      # Error when response is empty
      class ResponseEmpty < RubyRabbitmqJanus::Errors::BaseRabbit
        def initialize(response)
          super "Response is empty ! (#{response})"
        end
      end

      # Error when response is nil
      class ResponseNil < RubyRabbitmqJanus::Errors::BaseRabbit
        def initialize(response)
          super "Response is nil ! (#{response})"
        end
      end
    end

    module Publisher
      # Error when correlation string is not equal
      class TestCorrelation < RubyRabbitmqJanus::Errors::BaseRabbit
        def initialize(message, propertie)
          super "Correlation doesn't equal (msg: #{message}) != (prp: #{propertie})"
        end
      end
    end
  end
end
