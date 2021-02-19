# frozen_string_literal: true

require 'rrj/process/thread_runner_concern'

module RubyRabbitmqJanus
  module Process
    module Concurrencies
      # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
      #
      # # Listen public queue to all Janus instance
      #
      # Listen standard queue and sending a block code to thread listen.
      # The default queue is configured in config file.
      #
      # @see file:/config/default.md For more information to config file used.
      class Event < Concurrency
        include RubyRabbitmqJanus::Process::Concurrencies::ThreadRunnerConcern

        private

        def name_publisher
          :pub_classic
        end

        def publisher
          Rabbit::Listener::From.new(rabbit)
        end

        def raise_nil_block
          raise RubyRabbitmqJanus::Errors::Process::Event::Run
        end
      end
    end
  end
end
