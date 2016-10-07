# frozen_string_literal: true

# :reek:FeatureEnvy and :reek:InstanceVariableAssumption
module RubyRabbitmqJanus
  module Rabbit
    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
    class Publish
      # Define Exchange operation
      def initialize(exchange)
        @exchange = exchange.default_exchange
      end

      # Send a message in queue
      def send_a_message(request)
        @exchange.publish(request.to_json, request.options)
      end
    end

    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
    class PublishReply < Publish
      # Define echange and create an reply queue
      def initialize(exchange)
        @reply = exchange.queue('', exclusive: true)
        @condition = ConditionVariable.new
        @lock = Mutex.new
        @response = nil
        subscribe_to_queue
        super
      end

      def send_a_message(request)
        @exchange.publish(request.to_json, request.options.merge!(reply_to: @reply.name))
        @lock.synchronize { @condition.wait(@lock) }
        Log.instance.debug "Response ... #{@response}"
        @response
      end

      private

      # Subscribe to queue in Rabbitmq
      def subscribe_to_queue
        @reply.subscribe do |_delivery_info, _properties, payload|
          @response = JSON.parse payload
          @lock.synchronize { @condition.signal }
          Log.instance.debug "Response skdfjgnlkf,l... #{@response}"
        end
      end
    end
  end
end
