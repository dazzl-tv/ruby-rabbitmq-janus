# frozen_string_literal: true

module RubyRabbitmqJanus
  module Tools
    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>

    # # Utility for manage option to this gem.
    #
    # This class start all singleton, Log, Config, Request and Keepalice
    # instance. It's alos used for testing session/handle used in request.
    class Option
      attr_reader :hash

      def initialize
        Log.instance
        Config.instance
        Requests.instance
        @session = Janus::Concurrencies::Keepalive.instance.session
        @hash = {}
      end

      def keepalive
        @session
      end

      def use_current_session?(options)
        @hash = options
        @hash['session_id'] = @session if session_exist?
        @hash['session_id']
      end

      private

      def session_exist?
        !@hash.key?('session_id')
      end
    end
  end
end
