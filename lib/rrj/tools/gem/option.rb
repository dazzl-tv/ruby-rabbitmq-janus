# frozen_string_literal: true

# :reek:FeatureEnvy
# :reek:UtilityFunction

module RubyRabbitmqJanus
  module Tools
    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>

    # # Utility for manage option to this gem.
    #
    # This class start all singleton, Log, Config, Request and Keepalive
    # instance. It's also used for testing session/handle used in request.
    class Option
      def initialize
        Config.instance
        Requests.instance
      end

      # Determine session_id used
      #
      # @param [Hash] options Read options used in request
      #
      # @return [Fixnum] Session ID
      #
      # @since 2.0.0
      def use_current_session?(options)
        if options.key?('session_id')
          options['session_id']
        else
          Models::JanusInstance.first.session
        end
      end

      # Determine handle_id used
      #
      # @param [Hash] options Read options used in request
      #
      # @return [Fixnum] Handle ID
      #
      # @since 2.0.0
      def use_current_handle?(options)
        options.key?('handle_id') ? options['handle_id'] : 0
      end
    end
  end
end
