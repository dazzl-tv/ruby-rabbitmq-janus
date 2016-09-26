# frozen_string_literal: true

module RubyRabbitmqJanus
  # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
  # Message Janus sending to rabbitmq server
  class ASync < MessageJanus
    def initialize(opts_request, channel)
      super
      @response = nil
      @condition = ConditionVariable.new
      @lock = Mutex.new
      @reply = channel.queue('', exclusive: true)
    end

    # Send a message to RabbitMQ server
    # @param json [String] Name of request used
    # @param channel [Bunny::Channel] Channel used in transaction
    # @param queue_to [String] Name of queue used for sending request in RabbitMQ
    # @return [Hash] Result to request executed
    def send(json)
      Log.instance.debug 'Send a message ASYNCHRONE'
      subscribe
      channel_publish_message(json)
    end

    private

    attr_reader :lock, :response

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

    def subscribe
      @reply.subscribe do |_delivery_info, properties, payload|
        parse_queue properties, payload
      end
    end

    def parse_queue(properties, payload)
      if properties[:correlation_id] == correlation
        @response = JSON.parse payload
        Log.instance.debug "#{@response.class} #{@response}"
        @lock.synchronize { @condition.signal }
      end
    end
  end
end
