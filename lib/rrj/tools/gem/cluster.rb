# frozen_string_literal: true

module RubyRabbitmqJanus
  module Tools
    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>

    # # Manage Janus instance
    class Cluster
      include Singleton

      attr_reader :number, :enable

      def initialize
        @current_instance = define_worker
        @enable = Config.instance.cluster?
        @number = Config.instance.options['janus']['cluster']['count'].to_i \
          if @enable
      end

      def find_sessions(instance)
        @current_instance = instance
        Tools::JanusInstance.find_by(instance: instance).session
      end

      def sessions
        Tools::JanusInstance.create(instance: define_worker,
                                    session: session_number,
                                    enable: true).session
      end

      def queue_to(instance = nil)
        Tools::Config.instance.options['queues']['standard']['to'] + \
          "-#{instance.blank? ? @current_instance : instance}"
      end

      def queue_admin_to(instance = nil)
        Tools::Config.instance.options['queues']['admin']['to'] + \
          "-#{instance.blank? ? @current_instance : instance}"
      end

      private

      def define_worker
        defined?(::WORKER) ? ::WORKER + 1 : 1
      end

      def session_number
        Janus::Concurrencies::Keepalive.instance.session
      end
    end
  end
end
