# frozen_string_literal: true

# @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
# @see RubyRabbitmqJanus::Janus::Keepalive Keepalive thread

module RubyRabbitmqJanus
  module Errors
    module Janus
      # Define a super class for all error in Janus::Concurency::Keepalive
      class BaseKeepalive < RubyRabbitmqJanus::Errors::Janus::BaseConcurency
        def initialize(message)
          super "[Keepalive] #{message}"
        end
      end

      module Keepalive
        # Error for Janus::Concurency::Keepalive#initialize
        class Initializer < RubyRabbitmqJanus::Errors::Janus::BaseKeepalive
          def initializer
            super 'Error keepalive initializer'
          end
        end

        # Error for Janus::Concurency::Keepalive#session
        class Session < RubyRabbitmqJanus::Errors::Janus::BaseKeepalive
          def initializer
            super 'Error return session number'
          end
        end
      end
    end
  end
end
