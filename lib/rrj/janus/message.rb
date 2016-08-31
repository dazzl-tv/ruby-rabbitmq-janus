# frozen_string_literal: true

require 'json'
require 'securerandom'

module RRJ
  # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
  # Message Janus sending to rabbitmq server
  class MessageJanus
    # Initialiaze a message posting to RabbitMQ
    def initialize(opts)
      @transaction = [*('A'..'Z'), *('0'..'9')].sample(10).join
      @correlation = SecureRandom.uuid
      @my_request = nil
      @opts = opts
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
      replace_transaction
      replace_session
      replace_handle
      @my_request.to_json
    end

    # Replace a transaction field with an String format
    def replace_transaction
      @my_request['transaction'] = @transaction
    end

    # Replace a session_id field with an Integer
    def replace_session
      @my_request['session_id'] = @opts['data']['id'] if @my_request['session_id']
    end

    # Replace a handle field with an Integer
    def replace_handle
      @my_request['handle_id'] = 123_456_789 if @my_request['handle_id']
    end

    # Prepare an Hash with information necessary to read a response in RabbitMQ queue
    def return_info_message
      @my_request.merge('correlation' => @correlation)
    end
  end
end
