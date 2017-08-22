# frozen_string_literal: true

# :reek:IrresponsibleModule
#
# rubocop:disable Metrics/LineLength
# rubocop:disable Style/Documentation

module RubyRabbitmqJanus
  module Errors
    module Janus
      # Define a super class for all error in Janus::Concurency::Keepalive
      class BaseKeepaliveInitializer < BaseKeepalive
        def initialize(message)
          super "[Initializer] #{message}"
        end
      end

      module KeepaliveInitializer
        # Error for Janus::Concurency::Keepalive#initialize
        class Initializer < RubyRabbitmqJanus::Errors::Janus::BaseKeepaliveInitializer
          def initializer
            super 'Error keepalive initializer'
          end
        end

        # Error for Janus::Concurency::Keepalive#session
        class Session < RubyRabbitmqJanus::Errors::Janus::BaseKeepaliveInitializer
          def initializer
            super 'Error return session number'
          end
        end

        class Thread < RubyRabbitmqJanus::Errors::Janus::BaseKeepaliveInitializer
          def initializer
            super 'Error for get Object Thread ID'
          end
        end

        class ThreadStart < RubyRabbitmqJanus::Errors::Janus::BaseKeepaliveInitializer
          def initializer
            super 'Error for starting timer in thread'
          end
        end

        class ThreadStop < RubyRabbitmqJanus::Errors::Janus::BaseKeepaliveInitializer
          def initializer
            super 'Error for stoping timer in thread'
          end
        end

        class ThreadDelete < RubyRabbitmqJanus::Errors::Janus::BaseKeepaliveInitializer
          def initializer
            super 'Error for destroy thread'
          end
        end
      end
    end
  end
end
# rubocop:enable Style/Documentation
# rubocop:enable Metrics/LineLength
