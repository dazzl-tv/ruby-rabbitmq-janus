# frozen_string_literal: true

require 'json'
require 'securerandom'

module RubyRabbitmqJanus
  # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
  # Message Janus sending to rabbitmq server
  class MessageJanus
    # Initialiaze a message posting to RabbitMQ
    # @param plugins [String] Name of plugin used by transaction
    # @param logs [RubyRabbitmqJanus::Log] Instance log
    # @param opts [Hash] Contains information to request sending
    def initialize(plugins, logs, opts)
      @correlation = SecureRandom.uuid
      @opts = opts
      @plugins = plugins
      @logs = logs
      @my_request = nil
      @message = nil
    end

    # Send a message to RabbitMQ server
    # @param json [String] Name of request used
    # @param channel [Bunny::Channel] Channel used in transaction
    # @param queue_to [String] Name of queue used for sending request in RabbitMQ
    # @return [Hash] Result to request executed
    def send(json, channel, queue_to)
      @message = channel.default_exchange
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

    # Replace element in json request with information used byt transaction
    def replaces
      replace_transaction
      if @opts
        replace_element('session_id')
        replace_plugin
        replace_element(@opts['handle_id'] ? 'handle_id' : 'sender', 'handle_id')
      end
    end

    # Replace a transaction field with an String format
    def replace_transaction
      @my_request['transaction'] = [*('A'..'Z'), *('0'..'9')].sample(10).join
    end

    # Replace a session_id field with an Integer
    def replace_element(value, value_replace = value)
      add_return(value_replace, value_data_or_precise(value)) \
        if @my_request[value_replace]
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
      @my_request['correlation'] = @correlation
      @logs.debug @my_request
      @my_request
    end

    # Format the json used for request sending
    def add_return(key, value)
      @my_request[key] = value
      @my_request.merge!(key => value)
    end

    # Format the response return
    def value_data_or_precise(key)
      @opts[key] || @opts['data']['id']
    end
  end
end
