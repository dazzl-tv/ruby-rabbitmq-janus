# frozen_string_literal: true

require 'rrj/models/concerns/janus_instance_concern'
if defined?(Mongoid)
  require 'rrj/models/mongoid'
else
  require 'rrj/models/active_record'
end

# :reek:FeatureEnvy

module RubyRabbitmqJanus
  module Tools
    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>

    # # Utility for manage option to this gem.
    #
    # This class start all singleton, Log, Config, Request and Keepalive
    # instance. It's also used for testing session/handle used in request.
    class Option
      def initialize
        Log.instance
        Config.instance
        Requests.instance
        cluster_mode
      rescue => error
        raise Errors::Tools::Option::Initialize, error
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
      rescue
        raise Errors::Tools::Option::UseCurrentSession, options
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
      rescue
        raise Errors::Tools::Option::UseCurrentHandle, options
      end

      private

      def cluster_mode
        method = Config.instance.cluster ? :restart_session : :create_session
        Cluster.instance.send(method)
      rescue
        raise Errors::Tools::Option::ClusterMode
      end
    end
  end
end
