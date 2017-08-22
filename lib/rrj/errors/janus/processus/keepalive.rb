# frozen_string_literal: true

# @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
# @see RubyRabbitmqJanus::Janus::Keepalive Keepalive thread

module RubyRabbitmqJanus
  module Errors
    module Janus
      # Define a super class for all error in Janus::Concurency::Keepalive
      class BaseKeepalive < RubyRabbitmqJanus::Errors::Janus::BaseConcurency
        def initialize(message)
          super "[Keepalive]#{message}"
        end
      end
    end
  end
end

require 'rrj/errors/janus/processus/keepalive/initializer'
require 'rrj/errors/janus/processus/keepalive/thread'
require 'rrj/errors/janus/processus/keepalive/timer'
