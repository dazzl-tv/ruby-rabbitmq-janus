# frozen_string_literal: true

require 'json'

module RubyRabbitmqJanus
  # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
  # Response Janus received to RabbitMQ server
  class ResponseJanus
    # Initialiaze a response reading in RabbitMQ queue
    def initialize(channel, connection, opts = {})
      @channel = channel
      @connection = connection
      @opts = opts
      @response = nil
    end

    # Read a response to janus (in RabbitMQ queue)
    # @return [Hash] resultat to request
    def read
      Log.instance.debug 'Read a response'
      the_queue = @channel.queue(Config.instance.options['queues']['queue_from'])
      the_queue.subscribe(block: true) do |info, prop, pay|
        listen(info, prop, pay)
      end
      return_response_json
    end

    private

    # Listen a response to queue
    def listen(_delivery_info, properties, payload)
      if @opts['properties']['correlation'] == properties[:correlation_id]
        @response = payload
        @connection.close
      end
    end

    # Format the response returning
    def return_response_json
      @response = JSON.parse(@response)
      case @opts['janus']
      when 'create'
        merge('session_id')
      when 'attach'
        merge('handle_id')
      end
      @response
    end

    # Update value to element in Hash
    def merge(key)
      @response[key] = @response['data']['id']
    end
  end
end
