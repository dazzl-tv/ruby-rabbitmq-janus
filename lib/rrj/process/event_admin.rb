# frozen_string_literal: true

require 'rrj/process/thread_runner_concern'

module RubyRabbitmqJanus
  module Process
    module Concurrencies
      # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
      #
      # # Listen admin queue to all Janus instance
      #
      # Listen admin queue and sending a block code to thread listen.
      # The default queue is configured in config file.
      #
      # @see file:/config/default.md For more information to config file used.
      class EventAdmin < Concurrency
        include RubyRabbitmqJanus::Process::Concurrencies::ThreadRunnerConcern

        private

        def name_publisher
          :pub_admin
        end

        def publisher
          Rabbit::Listener::FromAdmin.new(rabbit)
        end

        def raise_nil_block
          raise RubyRabbitmqJanus::Errors::Process::EventAdmin::Run
        end
      end
    end
  end
end
