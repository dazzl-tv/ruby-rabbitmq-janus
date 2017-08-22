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
    end
  end
end
