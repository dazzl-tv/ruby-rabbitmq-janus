# frozen_string_literal: true

module RubyRabbitmqJanus
  # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
  # Message Janus sending to rabbitmq server
  class MessageJanus
    # Initialiaze a message posting to RabbitMQ
    # @param channel [Bunny::Channel] Channel used in rabbitmq for storage message
    # @param opts_request [Hash] Contains information to request sending
    def initialize(opts_request, channel)
      @correlation = SecureRandom.uuid
      @options_request = opts_request
      @channel = channel
    end

    private

    attr_reader :correlation, :my_request, :message, :channel

    # Format request sending to rabbitmq to json format
    # @param json [Hash] request base
    # @return [JSON] Request to JSON format
    def define_request_sending(json)
      request = Replace.new(json, @options_request)
      @my_request = request.to_hash
      request.to_json
    end
  end
end
