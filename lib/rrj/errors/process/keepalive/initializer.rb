# frozen_string_literal: true

# :reek:IrresponsibleModule

module RubyRabbitmqJanus
  module Errors
    module Process
      class BaseKeepaliveInitializer < BaseKeepalive
        def initialize(message)
          super "[Initializer] #{message}"
        end
      end

      module KeepaliveInitializer
        class Initializer < RubyRabbitmqJanus::Errors::Janus::BaseKeepaliveInitializer
          def initialize
            super 'Error keepalive initializer'
          end
        end

        class ID2ref < RubyRabbitmqJanus::Errors::Janus::BaseKeepaliveInitializer
          def initialize(thread_id)
            super "No thread with ID : #{thread_id}"
          end
        end

        class Session < RubyRabbitmqJanus::Errors::Janus::BaseKeepaliveInitializer
          def initialize
            super 'Error return session number'
          end
        end

        class Thread < RubyRabbitmqJanus::Errors::Janus::BaseKeepaliveInitializer
          def initialize
            super 'Error for get Object Thread ID'
          end
        end

        class ThreadStart < RubyRabbitmqJanus::Errors::Janus::BaseKeepaliveInitializer
          def initialize
            super 'Error for starting timer in thread'
          end
        end

        class ThreadStop < RubyRabbitmqJanus::Errors::Janus::BaseKeepaliveInitializer
          def initialize
            super 'Error for stoping timer in thread'
          end
        end

        class ThreadDelete < RubyRabbitmqJanus::Errors::Janus::BaseKeepaliveInitializer
          def initialize
            super 'Error for destroy thread'
          end
        end
      end
    end
  end
end
