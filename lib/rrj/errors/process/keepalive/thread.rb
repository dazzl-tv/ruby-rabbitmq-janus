# frozen_string_literal: true

# :reek:IrresponsibleModule

module RubyRabbitmqJanus
  module Errors
    module Process
      # Define a super class for all error in Process::Concurency::Keepalive
      class BaseKeepaliveThread < BaseKeepalive
        def initialize(message)
          super "[Thread] #{message}"
        end
      end

      module KeepaliveThread
        class Initializer < RubyRabbitmqJanus::Errors::Process::BaseKeepaliveThread
          def initialize
            super 'Error for initialize Keepalive Thread'
          end
        end

        class InitializeJanusSession < RubyRabbitmqJanus::Errors::Process::BaseKeepaliveThread
          def initialize
            super 'Error when initialize message in keepalive thread'
          end
        end

        class RestartSession < RubyRabbitmqJanus::Errors::Process::BaseKeepaliveThread
          def initialize
            super 'Error when restart session'
          end
        end

        class Start < RubyRabbitmqJanus::Errors::Process::BaseKeepaliveThread
          def initialize
            super 'Error when start a loop for sending keepalive message'
          end
        end

        class Kill < RubyRabbitmqJanus::Errors::Process::BaseKeepaliveThread
          def initialize
            super 'Error when killing thread'
          end
        end

        class InstanceIsDown < RubyRabbitmqJanus::Errors::Process::BaseKeepaliveThread
          def initialize
            super 'Error when instance is down'
          end
        end
      end
    end
  end
end
