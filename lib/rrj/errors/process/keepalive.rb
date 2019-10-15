# frozen_string_literal: true

# @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
# @see RubyRabbitmqJanus::Janus::Keepalive Keepalive thread

module RubyRabbitmqJanus
  module Errors
    module Process
      # Define a super class for all error in Process::Concurency::Keepalive
      class BaseKeepalive < RubyRabbitmqJanus::Errors::Janus::BaseConcurency
        def initialize(message)
          super "[Keepalive]#{message}"
        end
      end
    end
  end
end

require 'rrj/errors/process/keepalive/initializer'
require 'rrj/errors/process/keepalive/thread'
require 'rrj/errors/process/keepalive/timer'
