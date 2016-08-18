# frozen_string_literal: true

require 'json'
require 'securerandom'

module RRJ
  # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
  # Model for Janus message sending or received to rabbitmq server
  # @!attribute [r] transaction
  #   @return [String] represente a random string (letter uppercase and number) with
  #   length to 10
  class MessageJanus
    attr_reader :transaction, :correlation_id

    # Type message janus
    TYPE = %w(
      :ack :attach :create :destroy :detach :event :error
      :hangup :info :keepalive :media :message :server_info
      :success :trickle :webrtcup
    ).freeze

    def initialize
      @transaction = [*('A'..'Z'), *('0'..'9')].sample(10).join
      @correlation_id = SecureRandom.uuid
    end

    # Write a message for janus format
    # @see TYPE
    # @param [Symbol] type Define type message sending
    # @param [Hash] body The body to message sending
    # @option body [Boolean] :audio Frame audio
    # @return [JSON] Message sending to RabbitMQ server
    def msg(type, body = {})
      hash = { janus: type, transaction: @transaction }
      hash.merge(body: body) unless body.empty?
      hash.to_json
    end
  end
end
