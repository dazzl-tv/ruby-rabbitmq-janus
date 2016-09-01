# frozen_string_literal: true

require 'json'
require 'securerandom'

module RRJ
  # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
  # Message Janus sending to rabbitmq server
  class MessageJanus
    # Initialiaze a message posting to RabbitMQ
    def initialize(plugins, opts)
      @correlation = SecureRandom.uuid
      @opts = opts
      @plugins = plugins
    end

    # Send a message to RabbitMQ server
    def send(json, channel, queue_to)
      @message = channel.default_exchange
      @reply_queue = channel.queue('', exclusive: true)
      @message.publish(test_request_and_replace(json),
                       routing_key: queue_to,
                       correlation_id: @correlation,
                       content_type: 'application/json')
      return_info_message
    end

    private

    # Prepare a hash request and replace information necessary for janus
    def test_request_and_replace(json_file)
      @my_request = JSON.parse(File.read(json_file))
      replaces
      @my_request.to_json
    end

    def replaces
      replace_transaction
      if @opts
        replace_element('session_id')
        replace_plugin
        replace_element('handle_id')
      end
    end

    # Replace a transaction field with an String format
    def replace_transaction
      @my_request['transaction'] = [*('A'..'Z'), *('0'..'9')].sample(10).join
    end

    # Replace a session_id field with an Integer
    def replace_element(value)
      add_return(value, value_data_or_precise(value)) if @my_request[value]
    end

    # Replace plugin used for transaction
    def replace_plugin
      my_plugin = @my_request['plugin']
      if my_plugin
        my_plugin = @plugins[my_plugin.delete('<plugin[').delete(']').to_i]
        add_return('plugin', my_plugin)
      end
    end

    # Prepare an Hash with information necessary to read a response in RabbitMQ queue
    def return_info_message
      @my_request.merge('correlation' => @correlation)
    end

    def add_return(key, value)
      @my_request[key] = value
      @my_request.merge(key => value)
    end

    def value_data_or_precise(key)
      @opts[key] || @opts['data']['id']
    end
  end
end
