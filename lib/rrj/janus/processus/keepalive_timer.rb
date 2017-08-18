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
        TIME_SESSION = 5
        TIME_PUBLISH = TIME_TO_LIVE + 1

        def initialize
          @timer = Timers::Group.new
          @running = true
          uts "INITIALIZE Keepalive Timer -- #{@running} -- #{@timer.inspect}"
        end

        def loop_keepalive(&block)
          @timer.now_and_every(TIME_TO_LIVE) { prepare_loop(&block) }
          loop do
            uts "[LOOP] Running : #{@running}"
            break unless @running
            execute_loop
          end
        end

        def session
          uts 'Get Session number'
          Timeout.timeout(TIME_SESSION) { yield }
        rescue Timeout::Error
          janus_instance_down
        end

        def stop
          uts "[STOP] Cancel to timer : #{@timer.inspect}"
          @timer.cancel
          uts "[STOP] Cancel to timer : #{@timer.inspect}"
          @timer.pause
          uts "[STOP] Cancel to timer : #{@timer.inspect}"
          @running = false
          uts "[STOP] Running : #{@running}"
        end

        private

        def prepare_loop(&block)
          Timeout.timeout(TIME_PUBLISH) { yield }
        rescue Timeout::Error
          janus_instance_down
        end

        def execute_loop
          uts "Execute loooooooooop"
          @timer.wait
        end

        def janus_instance_down
=begin
          uts "Janus Instance [##{@instance}] is down !!"
          Tools::Log.instance.fatal "Janus Instance [##{@instance}] is down !!"
          document.set(enable: false)
=end
          uts 'Janus Instance Down'
          @timer.pause
        end

        def uts(txt)
          puts "--> #{txt}".red
        end
      end
    end
  end
end
