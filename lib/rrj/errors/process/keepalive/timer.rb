# frozen_string_literal: true

# :reek:IrresponsibleModule

module RubyRabbitmqJanus
  module Errors
    module Process
      class BaseKeepaliveTimer < BaseKeepalive
        def initialize(message)
          super "[Timer] #{message}"
        end
      end

      module KeepaliveTimer
        class Initializer < RubyRabbitmqJanus::Errors::Process::BaseKeepaliveTimer
          def initialize
            super 'Error for initialize Keepalive Timer'
          end
        end

        class LoopKeepalive < RubyRabbitmqJanus::Errors::Process::BaseKeepaliveTimer
          def initialize
            super 'Loop for create timer in Keepalive Thread is failed'
          end
        end

        class Session < RubyRabbitmqJanus::Errors::Process::BaseKeepaliveTimer
          def initialize
            super 'Timeout for get session number in keepalive request'
          end
        end

        class StopTimer < RubyRabbitmqJanus::Errors::Process::BaseKeepaliveTimer
          def initialize
            super 'Error when timer to Keepalive Thread stop'
          end
        end

        class StartTimer < RubyRabbitmqJanus::Errors::Process::BaseKeepaliveTimer
          def initialize
            super 'Error when timer to Keepalive Thread start'
          end
        end
      end
    end
  end
end
