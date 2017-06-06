# frozen_string_literal: true

module RubyRabbitmqJanus
  module Errors
    module Rabbit
      # Define a super class for all errors in Rabbit::Publisher::Listener
      class BaseListener < BaseErrorPublisher
        def initialize(message, level = :fatal)
          super "[Listener] #{message}", level
        end
      end

      module Listener
        # Error for Rabbit::Publisher::Listener#initialize
        class Initialize < RubyRabbitmqJanus::Errors::Rabbit::BaseListener
          def initialize
            super 'Error in initializer'
          end
        end

        # Error for Rabbit::Publisher::Listener#listen_events
        class ListenEvents < RubyRabbitmqJanus::Errors::Rabbit::BaseListener
          def initialize
            super 'Error for listen events in RabbitMQ public queue'
          end
        end
      end
    end
  end
end
