# frozen_string_literal: true

module RubyRabbitmqJanus
  # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
  # Message Janus sending to rabbitmq server
  class MessageASyncJanus < MessageJanus
    def initialize(opts_request, channel, options)
      super
      @response = nil
    end

    # Send a message to RabbitMQ server
    # @param json [String] Name of request used
    # @param channel [Bunny::Channel] Channel used in transaction
    # @param queue_to [String] Name of queue used for sending request in RabbitMQ
    # @return [Hash] Result to request executed
    def send(json)
      lock = channel_subscribe
      lock.synchronize { condition.wait(lock) }
      channel_publish_message(json)
      @response
    end

    private

    attr_reader :lock, :reply, :response

    def channel_subscribe
      lock = Mutex.new
      subscribe(lock)
      lock
    end

    def channel_publish_message(json)
      message = channel.default_exchange
      message.publish(define_request_sending(json),
                      reply_to: reply.name,
                      routing_key: opts['janus']['queue_to'],
                      correlation_id: correlation,
                      content_type: 'application/json')
    end

    def subscribe(lock)
      @condition = ConditionVariable.new
      reply = channel.queue('', exclusive: true)
      reply.subscribe do |_delivery_info, properties, payload|
        parse_queue properties, payload, lock
      end
    end

    def parse_queue(properties, payload, lock)
      if properties[:correlation_id] == correlation
        @response = JSON.parse payload
        lock.synchronize { condition.signal }
      end
    end
  end
end
