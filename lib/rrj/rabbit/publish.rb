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
        @message = nil
      end

      # Send a message in queue
      def send_a_message(request)
        Tools::Log.instance.info "Send request type : #{request.type}"
        @message = request
        @exchange.publish(@message.to_json, request.options)
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
        super(exchange)
      end

      # Publish an message in rabbitmq
      def send_a_message(request)
        Tools::Log.instance.info "Send request type : #{request.type}"
        @exchange.publish(read_message(request),
                          request.options.merge!(reply_to: @reply.name))
        @lock.synchronize { @condition.wait(@lock) }
        @response
      end

      private

      # Read message and return to JSON format
      def read_message(request)
        @message = request
        @message.to_json
      end

      # Subscribe to queue in Rabbitmq
      # :reek:NilCheck
      def subscribe_to_queue
        @reply.subscribe do |_delivery_info, properties, payload|
          if !@message.nil? && @message.correlation.eql?(properties.correlation_id)
            @response = JSON.parse payload
            @lock.synchronize { @condition.signal }
          end
        end
      end
    end

    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
    # Publish message in non exclusive queue
    class PublishNonExclusive < PublishReply
      # Initialize an queue non exclusive
      def initialize(exchange)
        @reply = exchange.queue(Tools::Config.instance.options['queues']['queue_from'])
        super(exchange)
      end
    end

    # Publish for admin Janus
    class PublishAdmin < PublishReply
      # Initialize an queue non exclusive
      def initialize(exchange)
        name = Tools::Config.instance.options['queues']['admin']['queue_from']
        @reply = exchange.queue(name)
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

    # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
    # Publisher just for listen a classic out queue
    class PublishListen
      # Initialize publisher object for listen an classic queue to Janus
      def initialize(rabbit)
        @count = 1
        @rabbit = rabbit.channel
        @reply = @rabbit.queue(Tools::Config.instance.options['queues']['queue_from'])
        Tools::Log.instance.debug "Waiting message from queue : #{@reply.name}"
      end

      # Listen a queue an return a body response
      def listen_events
        @reply.subscribe(block: true) do |_info, _properties, payload|
          @response = JSON.parse payload
          Tools::Log.instance.debug "[X] #{@response['janus']} | num : #{@count}"
          @count += 1
        end
        @response
      end
    end
  end
end
