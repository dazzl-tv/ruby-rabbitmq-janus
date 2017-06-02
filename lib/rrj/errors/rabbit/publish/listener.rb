# frozen_string_literal: true

module RubyRabbitmqJanus
  module Errors
    module Rabbit
      class BaseListener < BaseErrorPublisher
        def initialize(message, level = :fatal)
          super "[Listener] #{message}", level
        end
      end

      module Listener
        class Initialize < RubyRabbitmqJanus::Errors::Rabbit::BaseListener
          def initialize
            super 'Error in initializer'
          end
        end

        class ListenEvents < RubyRabbitmqJanus::Errors::Rabbit::BaseListener
          def initialize
            super 'Error for listen events in RabbitMQ public queue'
          end
        end
      end
    end
  end
end
