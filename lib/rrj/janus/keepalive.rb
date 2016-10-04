# frozen_string_literal: true

module RubyRabbitmqJanus
  # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
  # Manage sending keepalive message
  class Keepalive
    def initialize
      Log.instance.info 'Start a seesion keepalive'
      live_session
    end

    private

    def live_session
      time_to_live = Config.instance.options['gem']['session']['keepalive'].to_i
      Thread.new do
        loop do
          sleep time_to_live
          Log.instance.unknown 'send message keepalive'
        end
      end
    end
  end
end
