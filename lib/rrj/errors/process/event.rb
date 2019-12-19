# frozen_string_literal: true

module RubyRabbitmqJanus
  module Errors
    module Process
      module Event
        class Base < RubyRabbitmqJanus::Errors::RRJError
          def initialize(klass, message, level = :warn)
            super "[Concurrency][#{klass}] #{message}", level
          end
        end

        class Run < Base
          def initialize
            super 'Event', 'Failed start thread listener public queue !'
          end
        end
      end
    end
  end
end
