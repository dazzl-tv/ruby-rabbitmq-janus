# frozen_string_literal: true

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
      @my_request = RubyRabbitmqJanus::Replace(json, @logs, @opts)
      @message.publish(@my_request.to_json,
                       reply_to: 'test',
                       routing_key: queue_to,
                       correlation_id: @correlation,
                       content_type: 'application/json')
      return_info_message
    end

    private

    # Prepare an Hash with information necessary to read a response in RabbitMQ queue
    def return_info_message
      @my_request['correlation'] = @correlation
      @logs.debug @my_request
      @my_request
    end
  end
end
