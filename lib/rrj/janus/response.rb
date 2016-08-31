# frozen_string_literal: true

require 'json'

module RRJ
  # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
  # Response Janus received to RabbitMQ server
  class ResponseJanus
    def initialize(consumer, channel, opts = {})
      @consumer = consumer.the_consumer
      @channel = channel
      @opts = opts
    end

    # Read a response to janus (in RabbitMQ queue)
    # @return [Hash] resultat to request
    def read(queue_from)
      option_sub = { block: true }
      the_queue = @channel.queue(queue_from)
      the_queue.subscribe(option_sub) do |info, prop, pay|
        listen(info, prop, pay)
        # @response = payload && @opts['correlation'] == prop[:correlation_id]
      end
      JSON.parse(@response)
    end

    private

    # Listen a response to queue
    def listen(delivery_info, properties, payload)
      if @opts['correlation'] == properties[:correlation_id]
        @response = payload
        @channel.consumers[delivery_info.consumer_tag].cancel
      end
    end
  end
end
