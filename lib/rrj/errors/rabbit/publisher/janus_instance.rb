# frozen_string_literal: true

module RubyRabbitmqJanus
  module Errors
    module Rabbit
      module Publisher
        module JanusInstance
          class Initialize < RubyRabbitmqJanus::Errors::Rabbit::Publisher::BasePublishExclusive
            def initialize
              super 'Error in initializer'
            end
          end

          class Publish < RubyRabbitmqJanus::Errors::Rabbit::Publisher::BasePublisherAdmin
            def initialize
              super 'Error publish message in queue'
            end
          end
        end
      end
    end
  end
end
