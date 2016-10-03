# frozen_string_literal: true

module RubyRabbitmqJanus
  # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
  # Message Janus sending to rabbitmq server
  class ASync < MessageJanus
    # Initialiaze a message posting to RabbitMQ and asynchronous
    # @param channel [Bunny::Channel] Channel used in rabbitmq for storage message
    # @param opts_request [Hash] Contains information to request sending
    def initialize(opts_request, channel)
      super
      @response = nil
      @condition = ConditionVariable.new
      @lock = Mutex.new
      @reply = channel.queue('', exclusive: true)
    end

    # Send a message to RabbitMQ server
    # @param json [String] Name of request used
    # @return [Hash] Result to request executed
    def send(json)
      Log.instance.debug 'Send a message ASYNCHRONE'
      subscribe
      channel_publish_message(json)
    end

    private

    attr_reader :lock, :response

    # Pusblish an message to Rabbitmq queue for janus
    def channel_publish_message(json)
      message = channel.default_exchange
      message.publish(define_request_sending(json),
                      reply_to: @reply.name,
                      routing_key: Config.instance.options['queues']['queue_to'],
                      correlation_id: correlation,
                      content_type: 'application/json')
      @lock.synchronize { @condition.wait(lock) }
      @response
    end

    # Subscribe to queue in Rabbitmq
    def subscribe
      @reply.subscribe do |_delivery_info, properties, payload|
        parse_queue properties, payload
      end
    end

    # Parse queue in Rabbitmq
    def parse_queue(properties, payload)
      if properties[:correlation_id] == correlation
        @response = JSON.parse payload
        @lock.synchronize { @condition.signal }
      end
    end
  end
end
