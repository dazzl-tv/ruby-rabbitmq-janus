# frozen_string_literal: true

require 'json'

module RRJ
  # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
  # Model for Janus message sending or received to rabbitmq server
  # @!attribute [r] transaction
  #   @return [String] represente a random string (letter uppercase and number) with
  #   length to 10
  # @!attribute [r] body
  #   @return [String] Body to message
  class MessageJanus
    attr_reader :transaction, :body

    # Type message janus
    TYPE = %w(
      :ack :attach :create :destroy :detach :event :error
      :hangup :info :keepalive :media :message :server_info
      :success :trickle :webrtcup
    ).freeze

    # Write a message for janus format
    # @see TYPE
    # @param [Symbol] type Define type message sending
    # @param [Hash] body The body to message sending
    # @option body [Boolean] :audio Frame audio
    # @return [JSON] Message sending to RabbitMQ server
    def message(type, body = {})
      transaction = [*('A'..'Z'), *('0'..'9')].sample(10).join
      hash = { janus: type, transaction: transaction }
      hash.merge(body: body) unless body.empty?
      hash.to_json
    end

    private

    # Write message for return server info
    def message_server_info
    end

    # Write default message
    def message_default
      message_server_info
    end
  end
end
