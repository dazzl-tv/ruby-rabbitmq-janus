# frozen_string_literal: true

# :reek:FeatureEnvy and :reek:InstanceVariableAssumption
module RubyRabbitmqJanus
  module Rabbit
    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
    # @abstract Publish message in RabbitMQ
    class Publish
      # Define Exchange operation
      def initialize(exchange)
        Tools::Log.instance.debug 'Create/Connect to queue'
        @exchange = exchange.default_exchange
      end

      # Send a message in queue
      def send_a_message(request)
        Tools::Log.instance.info "Send request type : #{request.type}"
        @exchange.publish(request.to_json, request.options)
      end
    end

    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
    # @abstract Publish an message in RabbitMQ and waiting a response
    class PublishReply < Publish
      # Initialize a queue
      def initialize(exchange)
        @condition = ConditionVariable.new
        @lock = Mutex.new
        @response = nil
        subscribe_to_queue
        super
      end

      # Publish an message in rabbitmq
      def send_a_message(request)
        Tools::Log.instance.info "Send request type : #{request.type}"
        @exchange.publish(request.to_json, request.options.merge!(reply_to: @reply.name))
        @lock.synchronize { @condition.wait(@lock) }
        @response
      end

      private

      # Subscribe to queue in Rabbitmq
      def subscribe_to_queue
        @reply.subscribe do |_delivery_info, _properties, payload|
          @response = JSON.parse payload
          @lock.synchronize { @condition.signal }
        end
      end
    end

    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
    # Publish message in non exclusive queue
    class PublishNonExclusive < PublishReply
      # Initialize an queue non exclusive
      def initialize(exchange, name_queue = '')
        @reply = exchange.queue(name_queue)
        super(exchange)
      end
    end

    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
    # Publish message in exclusive queue
    class PublishExclusive < PublishReply
      # Initialize an queue exclusive
      def initialize(exchange, name_queue = '')
        @reply = exchange.queue(name_queue, exclusive: true)
        super(exchange)
      end

      # Name to queue
      # @return [String] Name to queue used
      def queue_name
        @reply.name
      end
    end
  end
end
