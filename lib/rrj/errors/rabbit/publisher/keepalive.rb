# frozen_string_literal: true

# :reek:IrresponsibleModule

module RubyRabbitmqJanus
  module Errors
    module Rabbit
      module Publisher
        module Keepalive
          class Initialize < RubyRabbitmqJanus::Errors::Rabbit::Publisher::BasePublishExclusive
            def initialize
              super 'Error in initializer'
            end
          end
        end
      end
    end
  end
end
