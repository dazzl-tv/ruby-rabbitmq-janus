# frozen_string_literal: true

require 'json'

module RRJ
  # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
  # Response Janus received to RabbitMQ server
  class ResponseJanus
    def initialize(channel, connection, opts = {})
      @channel = channel
      @connection = connection
      @opts = opts
    end

    # Read a response to janus (in RabbitMQ queue)
    # @return [Hash] resultat to request
    def read(queue_from)
      option_sub = { block: true, manual_ack: false }
      the_queue = @channel.queue(queue_from)
      the_queue.subscribe(option_sub) do |info, prop, pay|
        listen(info, prop, pay)
      end
      return_response_json
    end

    private

    # Listen a response to queue
    def listen(_delivery_info, properties, payload)
      if @opts['correlation'] == properties[:correlation_id]
        @response = payload
        @connection.close
      end
    end

    def return_response_json
      @response = JSON.parse(@response)
      case @opts['janus']
      when 'create'
        @response.merge('session_id' => resp)
      when 'attach'
        @response.merge('handle_id' => resp)
      end
    end

    def resp
      @response['data']['id']
    end
  end
end
