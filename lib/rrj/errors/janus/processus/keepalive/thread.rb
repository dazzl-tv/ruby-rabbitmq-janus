# frozen_string_literal: true

# :reek:IrresponsibleModule

module RubyRabbitmqJanus
  module Errors
    module Janus
      # Define a super class for all error in Janus::Concurency::Keepalive
      class BaseKeepaliveThread < BaseKeepalive
        def initialize(message)
          super "[Thread] #{message}"
        end
      end

      module KeepaliveThread
        class Initializer < RubyRabbitmqJanus::Errors::Janus::BaseKeepaliveThread
          def initialize
            super 'Error for initialize Keepalive Thread'
          end
        end

        class InitializeJanusSession < RubyRabbitmqJanus::Errors::Janus::BaseKeepaliveThread
          def initialize
            super 'Error when initialize message in keepalive thread'
          end
        end

        class RestartSession < RubyRabbitmqJanus::Errors::Janus::BaseKeepaliveThread
          def initialize
            super 'Error when restart session'
          end
        end

        class Start < RubyRabbitmqJanus::Errors::Janus::BaseKeepaliveThread
          def initialize
            super 'Error when start a loop for sending keepalive message'
          end
        end

        class Kill < RubyRabbitmqJanus::Errors::Janus::BaseKeepaliveThread
          def initialize
            super 'Error when killing thread'
          end
        end

        class InstanceIsDown < RubyRabbitmqJanus::Errors::Janus::BaseKeepaliveThread
          def initialize
            super 'Error when instance is down'
          end
        end
      end
    end
  end
end
