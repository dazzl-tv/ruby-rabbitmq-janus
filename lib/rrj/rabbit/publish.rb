# frozen_string_literal: true

module RubyRabbitmqJanus
  module Rabbit
    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
    class Publish
      # Define Exchange operation
      def initialize(exchange)
        @exchange = exchange.default_exchange
      end

      # Send a message in queue
      def send_a_message(request, correlation)
        @exchange.publish(request, option_publish(correlation))
      end

      private

      # Define options to message pusblishing in queue
      # @return [Hash]
      def option_publish(correlation)
        hash = {
          routing_key: Config.instance.options['queues']['queue_to'],
          correlation_id: correlation,
          content_type: 'application/json'
        }
        Log.instance.debug "Options for publishing a message : #{hash}"
        hash
      end
    end

    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
    class PublishReply < Publish
      # Define echange and create an reply queue
      def initialize(exchange)
        @reply = exchange.queue('', exclusive: true)
        super
      end

      private

      # Define options to message pusblishing in queue with reply configured
      # @return [Hash]
      def option_publish(correlation)
        super.merge!(reply_to: @reply.name)
      end
    end
  end
end
