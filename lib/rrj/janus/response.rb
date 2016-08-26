# frozen_string_literal: true

require 'json'

module RRJ
  # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
  # Response Janus received to RabbitMQ server
  class ResponseJanus
    attr_reader :response

    def initialize(opts = {})
      @correlation_id = opts[:correlation_id]
      @transaction = opts[:transaction]
    end

    # Read a response to janus (in RabbitMQ queue)
    # @return [Hash] resultat to request
    def read(channel, queue_from)
      @channel = channel
      the_queue = @channel.queue(queue_from)
      the_queue.subscribe(block: true, manual_ack: true) do |info, prop, pay|
        listen(info, prop, pay)
      end
      JSON.parse(@response)
    end

    private

    # Listen a response to queue
    def listen(delivery_info, properties, payload)
      if @correlation_id == properties[:correlation_id]
        @response = payload
        @channel.consumers[delivery_info.consumer_tag].cancel
      end
    end
  end
end
