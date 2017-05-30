# frozen_string_literal: true

# :reek:FeatureEnvy :reek:UtilityFunction

module RubyRabbitmqJanus
  module Tools
    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>

    # # Utility for manage option to this gem.
    #
    # This class start all singleton, Log, Config, Request and Keepalice
    # instance. It's alos used for testing session/handle used in request.
    class Option
      def initialize
        Log.instance
        Config.instance
        Requests.instance
        @session = Cluster.instance.sessions
      end

      # Give number session to keepalive
      #
      # @return [Fixnum] Session ID
      #
      # @since 2.0.0
      def keepalive
        @session
      end

      # Determine session_id used
      #
      # @param [Hash] options Read options used in request
      #
      # @return [Fixnum] Session ID
      #
      # @since 2.0.0
      def use_current_session?(options)
        hash = options
        hash['session_id'] = @session unless hash.key?('session_id')
        hash['session_id']
      end

      # Determine handle_id used
      #
      # @param [Hash] options Read options used in request
      #
      # @return [Fixnum] Handle ID
      #
      # @since 2.0.0
      def use_current_handle?(options)
        hash = options
        hash['handle_id'] = 0 unless hash.key?('handle_id')
        hash['handle_id']
      end
    end
  end
end
