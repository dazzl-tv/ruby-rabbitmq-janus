# frozen_string_literal: true

require 'timeout'
require 'timers'

module RubyRabbitmqJanus
  module Janus
    module Concurrencies
      # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
      #
      # # Manage time for thread
      #
      # Configure all timer used in keepalive class
      class KeepaliveTimer
        TIME_TO_LIVE = 15
        # TIME_TO_LIVE = Tools::Config.instance.ttl
        TIME_SESSION = 15
        TIME_PUBLISH = TIME_TO_LIVE + 1

        # Initialize timer to keeaplive thread.
        # Configure timer with :
        #   - interval for each keepalive message
        #   - timeout for session response
        #   - timeout for publish message
        def initialize
          @timer = Timers::Group.new
        end

        # Execute a loop with timer for sending keepalive message
        # to Janus Instance
        def loop_keepalive(&block)
          @timer.now_and_every(TIME_TO_LIVE) { prepare_loop(&block) }
          loop { @timer.wait }
        end

        # Test if session is present/exist in Janus Instance
        def session(&block)
          Timeout.timeout(TIME_SESSION) { yield }
        rescue Timeout::Error
          stop_timer
          block.binding.receiver.instance_is_down
        end

        # Stop timer to keepalive thread
        def stop_timer
          @timer.pause
        end

        # Start timer to keepalive thread
        def start_timer
          @timer.resume
        end

        private

        def prepare_loop(&block)
          Timeout.timeout(TIME_PUBLISH) do
            yield
          end
        rescue Timeout::Error
          stop_timer
          block.binding.receiver.instance_is_down
        end
      end
    end
  end
end
