# frozen_string_literal: true

module RubyRabbitmqJanus
  module Errors
    module Rabbit
      module Listener
        module From
          class ListenEvents < RubyRabbitmqJanus::Errors::Rabbit::Listener::BaseError
            def initialize(error)
              super "Error for listen events in RabbitMQ public queue, #{error}"
            end
          end
        end
      end
    end
  end
end
