# frozen_string_literal: true

require 'json'
require 'securerandom'

module RRJ
  # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
  # Message Janus sending to rabbitmq server
  class MessageJanus
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

    def test_request_and_replace(json_file)
      @my_request = JSON.parse(File.read(json_file))
      replace_transaction
      replace_session
      replace_handle
      @my_request.to_json
    end

    def replace_transaction
      @my_request['transaction'] = @transaction
    end

    def replace_session
      @my_request['session_id'] = @opts['data']['id'] if @my_request['session_id']
    end

    def replace_handle
      @my_request['handle_id'] = 123_456_789 if @my_request['handle_id']
    end

    def return_info_message
      @my_request.merge('correlation' => @correlation)
    end
  end
end
