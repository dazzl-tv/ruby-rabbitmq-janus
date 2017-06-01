# frozen_string_literal: true

module RubyRabbitmqJanus
  module Errors
    module Janus
      class BaseConcurency < RubyRabbitmqJanus::Errors::BaseJanus
        def initialize(message)
          super "[Concurency] #{message}"
        end
      end

      module Concurency
        class Initializer < RubyRabbitmqJanus::Errors::Janus::BaseConcurency
          def initialize
            super 'Error initialize concurency class'
          end
        end
      end
    end
  end
end
