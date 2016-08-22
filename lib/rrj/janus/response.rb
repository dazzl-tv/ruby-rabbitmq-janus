# frozen_string_literal: true

require 'json'

module RRJ
  # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
  # Response Janus received to RabbitMQ server
  class ResponseJanus
    def initialize(opts = {})
      @correlation_id = opts[:correlation_id]
      @transaction = opts[:transaction]
      @reply_queue_name = 'from-janus'
    end

    # Read a response to janus (in RabbitMQ queue)
    def read(channel)
      body = nil
      the_queue = channel.queue(@reply_queue_name)
      the_queue.subscribe(block: true, manual_ack: true) do |info, prop, pay|
        body = listen info, prop, pay
      end
      body
    end

    private

    def listen(_delivery_info, properties, payload)
      if @correlation_id == properties[:correlation_id]
        body = payload
        channel.consumers[delivery_info.consumer_tag].cancel
      end
      body
    end
  end
end
