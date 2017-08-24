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
      end

      # Create session (just one Janus Instance)
      def create_session
        @current_instance = 1
        Models::JanusInstance.create(instance: @current_instance)
      rescue
        raise Errors::Tools::Cluster::CreateSession
      end

      # Restart a thread keepalive for an instance
      def restart_session
        Models::JanusInstance.enabled.each do |ji|
          ji.send(:create_a_session_in_janus_instance)
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
    end
  end
end
