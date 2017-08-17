# frozen_string_literal: true

module RubyRabbitmqJanus
  module Tools
    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>

    # # Manage Janus instance
    class Cluster
      include Singleton

      attr_reader :sessions

      # Initialize object for managing each instance to Janus
      def initialize
        @current_instance = nil
        @sessions = []
      rescue
        raise Errors::Tools::Cluster::Initializer
      end

      # Create session (just one Janus Instance)
      def create_session
        @current_instance = 1
        create_session_instance
      rescue
        raise Errors::Tools::Cluster::CreateSession
      end

      # Restart a thread keepalive for an instance
      def restart_session
        RubyRabbitmqJanus::Models::JanusInstance.enabled.each do |janus|
          @current_instance = janus.instance
          janus.set(session: initialize_session)
        end
      rescue
        raise Errors::Tools::Cluster::RestartInstance
      end

      # Specify a name to queue
      def queue_to(instance = nil)
        Tools::Config.instance.options['queues']['standard']['to'] + \
          "-#{instance.blank? ? @current_instance : instance}"
      rescue
        raise Errors::Tools::Cluster::QueueTo
      end

      # Specify a name to admin queue
      def queue_admin_to(instance = nil)
        Tools::Config.instance.options['queues']['admin']['to'] + \
          "-#{instance.blank? ? @current_instance : instance}"
      rescue
        raise Errors::Tools::Cluster::QueueAdminTo
      end

      private

      # Create a thread for manage a session/keepalive with Janus
      def initialize_session
        Janus::Concurrencies::Keepalive.new(@current_instance).session
      end

      # create a new instance in database
      def create_session_instance
        Models::JanusInstance.create(instance: @current_instance,
                                     session: initialize_session,
                                     enable: true)
      end
    end
  end
end
