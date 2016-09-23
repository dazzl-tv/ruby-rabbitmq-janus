# frozen_string_literal: true

require 'securerandom'
require 'thread'

module RubyRabbitmqJanus
  # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
  # Message Janus sending to rabbitmq server
  class MessageJanus
    # Initialiaze a message posting to RabbitMQ
    # @param plugins [String] Name of plugin used by transaction
    # @param logs [RubyRabbitmqJanus::Log] Instance log
    # @param opts [Hash] Contains information to request sending
    def initialize(opts_request, channel)
      @correlation = SecureRandom.uuid
      @options_request = opts_request
      @channel = channel
    end

    private

    attr_reader :channel, :options_request, :opts, :correlation, :my_request, :message
    attr_reader :log

    def define_request_sending(json)
      request = Replace.new(json, @options_request)
      @my_request = request.to_hash
      request.to_json
    end
  end
end
