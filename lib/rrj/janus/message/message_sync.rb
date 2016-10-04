# frozen_string_literal: true

module RubyRabbitmqJanus
  # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
  # Message Janus sending to rabbitmq server
  class Sync < MessageJanus
    # Initialiaze a message posting to RabbitMQ and synchronous
    # @param channel [Bunny::Channel] Channel used in rabbitmq for storage message
    # @param opts_request [Hash] Contains information to request sending
    def initialize(opts_request, channel)
      super
    end

    # Send a message to RabbitMQ server
    # @param json [String] Name of request used
    # @return [Hash] Result to request executed
    def send(json)
      message = channel.default_exchange
      Log.instance.debug 'Send a message SYNCHRONE'
      message.publish(define_request_sending(json),
                      routing_key: Config.instance.options['queues']['queue_to'],
                      correlation_id: correlation,
                      content_type: 'application/json')
      return_info_message
    end

    private

    # Prepare an Hash with information necessary to read a response in RabbitMQ queue
    def return_info_message
      rqe = my_request.request.merge!('properties' => { 'correlation' => correlation })
      Log.instance.debug "@my_request #{rqe}"
      rqe
    end
  end
end
