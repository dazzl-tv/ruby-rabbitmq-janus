# frozen_string_literal: true

module RubyRabbitmqJanus
  module Tools
    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>

    # # Manage Janus instance
    class Cluster
      include Singleton

      attr_reader :number, :enable

      def initialize
        @enable = Config.instance.cluster?
        @number = Config.instance.options['janus']['cluster']['count'].to_i \
          if @enable
      end

      def sessions
        Janus::Concurrencies::Keepalive.instance.session
      end

      def queue_to
        #queue = Tools::Config.instance.options['queues']['standard']['to']
        #if defined?(::WORKER)
        #    "#{queue}-#{::WORKER + 1}"
        #else
        #  queue
        #end
        Tools::Config.instance.options['queues']['standard']['to'] + \
          "-#{::WORKER + 1}"
      end
    end
  end
end
