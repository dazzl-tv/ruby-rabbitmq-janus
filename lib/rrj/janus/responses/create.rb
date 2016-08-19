# frozen_string_literal: true

module RRJ
  # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
  # Read a response for message type :create
  class ResponseCreate < ResponseJanus
    # Customize a message reading in RabbitMQ queue
    def receive(channel, _logs)
      @queue = channel.queue(ROUTING)
      @queue.subscribe(block: true, manual_ack: false) do |info, properties, body|
        if properties.correlation_id == @correlation_id
          # logs.info 'Response :'
          # logs.debug body
          # logs.debug properties
          # logs.debug delivery_info
          @response = JSON.parse(body)
          # logs.info 'End response'
          # Stop block if response is return
          channel.consumers[info.consumer_tag].cancel
        end
      end
      @response['data']
    end
  end
end
