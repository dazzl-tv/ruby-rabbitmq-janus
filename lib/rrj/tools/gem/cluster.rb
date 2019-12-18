# frozen_string_literal: true

module RubyRabbitmqJanus
  module Tools
    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>

    # # Manage Janus instance
    class Cluster
      include Singleton

      # Initialize object for managing each instance to Janus
      def initialize
        @current_instance = nil
      end

      # Specify a name to queue
      def queue_to(instance = nil)
        Tools::Config.instance.options['queues']['standard']['to'] + \
          "-#{instance.blank? ? @current_instance : instance}"
      end

      # Specify a name to admin queue
      def queue_admin_to(instance = nil)
        Tools::Config.instance.options['queues']['admin']['to'] + \
          "-#{instance.blank? ? @current_instance : instance}"
      end
    end
  end
end
