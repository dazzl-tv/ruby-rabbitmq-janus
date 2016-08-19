# frozen_string_literal: true

require 'json'

module RRJ
  # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
  # Response Janus received to RabbitMQ server
  class ResponseJanus
    # Type message sending
    CONTENT_TYPE = 'application/json'

    # Queue to message listen
    ROUTING = 'from-janus'

    def receive(channel)
      @queue = channel.queue(ROUTING)
      @queue.subscribe do |_delivery_info, _properties, body|
        body
      end
    end
  end
end
