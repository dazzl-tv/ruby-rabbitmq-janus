# frozen_string_literal: true

require 'json'

module RRJ
  # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
  # Response Janus received to RabbitMQ server
  class ResponseJanus
    def initialize(channel, connection, logs, opts = {})
      @channel = channel
      @connection = connection
      @opts = opts
      @logs = logs
    end

    # Read a response to janus (in RabbitMQ queue)
    # @return [Hash] resultat to request
    def read(queue_from)
      option_sub = { block: true, manual_ack: false, exclusive: false }
      the_queue = @channel.queue(queue_from, auto_delete: false)
      the_queue.subscribe(option_sub) do |info, prop, pay|
        listen(info, prop, pay)
      end
      return_response_json
    end

    private

    # Listen a response to queue
    def listen(delivery_info, properties, payload)
      if @opts['correlation'] == properties[:correlation_id]
        @response = payload
        @channel.acknowledge(delivery_info.delivery_tag, false)
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
      @logs.debug @response
      @response
    end

    def resp
      @response['data']['id']
    end
  end
end
