# frozen_string_literal: true

module RubyRabbitmqJanus
  module Tools
    # Subclass for Config
    #
    # Options about Queues
    #
    # @see RubyRabbitmqJanus::Tools::Config
    module ConfigQueues
      # @return [String] Get to name queue_from (pattern)
      def queue_from
        @options['queues']['standard']['from'].to_s
      rescue => exception
        p "[queue_from] #{exception}"
      end

      # @return [String] Get to name queue_to (pattern)
      def queue_to
        @options['queues']['standard']['to'].to_s
      rescue => exception
        p "[queue_to] #{exception}"
      end

      # @return [String] Get to name queue_admin_from (pattern)
      def queue_admin_from
        @options['queues']['admin']['from'].to_s
      rescue => exception
        p "[queue_admin_from] #{exception}"
      end

      # @return [String] Get to name queue_admin_from (pattern)
      def queue_admin_to
        @options['queues']['admin']['to'].to_s
      rescue => exception
        p "[queue_admin_to] #{exception}"
      end

      # @return [String] Get to name queue JanusInstance
      def queue_janus_instance
        @options['queues']['instance'].to_s
      rescue => exception
        p "[queue_janus_instances] #{exception}"
      end
    end
  end
end
